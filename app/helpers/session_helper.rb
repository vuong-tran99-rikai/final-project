module SessionHelper
  def log_in(user)
    session[:user_id] = user.id
    session[:user_type] = user.type_account 
    session[:cart] = []
  end

  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  def current_user?(user)
    user && user == current_user
  end

  def logged?
    !current_user.nil?
  end

  def logged_in_user
    unless logged?
    flash[:danger] = "Please log in."
    redirect_to login_url
    end
  end

  def admin_user?
    return true if session[:user_type] == 'admin'
    return false
  end

  def admin_user
    return true if admin_user?
    redirect_to(root_url)
  end

  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  def log_out
    forget(current_user)
    session.delete(:user_id)
    session[:user_type] = 0
    @current_user = nil
  end

  def get_path
    URI.parse(request.original_url).path
  end

  
end
