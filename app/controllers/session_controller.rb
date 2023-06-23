class SessionController < ApplicationController
  def new
  end

  def create
    if params[:session][:email].empty? || params[:session][:password].empty?
      flash.now[:danger] = t('flash.error')
      render "new"
    elsif params[:session][:email].include?(" ") || params[:session][:password].include?(" ")
      flash.now[:danger] = t('flash.error')
      render "new"
    else
      user = User.find_by(email: params[:session][:email].downcase)
      if user && user.authenticate(params[:session][:password])
        if user.deleted?
          flash.now[:danger] = t('flash.error')
          render "new"
        elsif user.closed?
            flash.now[:danger] = t('flash.loginlock')
            render "new"
        else
          log_in user
          remember user
          flash[:success] = t('flash.login')
          redirect_to root_url
        end
      else
        flash.now[:danger] = t('flash.error')
        render "new"
      end
    end
    
  end

  def destroy
    log_out if logged?
    redirect_to root_url
  end

  def omniauth
    # binding.pry
    user = User.find_or_create_by(uid: request.env['omniauth.auth'][:uid] , provider: request.env['omniauth.auth'][:provider]) do |u|
        u.name = request.env['omniauth.auth'][:info][:last_name]
        u.email = request.env['omniauth.auth'][:info][:email]
        u.password_digest = SecureRandom.hex(15)
        u.type_account = 0
        u.status = 0
    end
    if user.valid?
        if user.opened?
          session[:user_id] = user.id
          flash[:success] = t('flash.login')
          redirect_to root_path
        else 
          flash[:danger] = t('flash.loginerror')
          redirect_to root_path
        end
    else
      flash[:danger] = t('flash.loginerror')
      redirect_to root_path
    end
  end
end

