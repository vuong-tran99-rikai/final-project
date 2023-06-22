class SessionController < ApplicationController
  def new
  end

  def create
    if params[:session][:email].empty? || params[:session][:password].empty?
      flash.now[:danger] = "Vui lòng nhập tài khoản, mật khẩu"
      render "new"
    else
      user = User.find_by(email: params[:session][:email].downcase)
      if user && user.authenticate(params[:session][:password])
        if user.deleted?
          flash.now[:danger] = "Tài khoản không tồn tại"
          render "new"
        elsif user.closed?
            flash.now[:danger] = "Tài khoản của bạn đã bị khóa"
            render "new"
        else
          log_in user
          remember user
          redirect_to root_url
        end
      else
        flash.now[:danger] = "Tài khoản hoặc mật khâu không chính xác"
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
        session[:user_id] = user.id
        flash[:success] = 'login thành công'
        redirect_to root_path
        else
        flash[:danger] = 'không login thất bại'
        redirect_to root_path
    end
  end

end

