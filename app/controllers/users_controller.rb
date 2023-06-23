class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update, :show]

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def edit 
    @user = User.find(params[:id])
  end

 

  def create
    @user = User.new(user_params.merge!(status: 0, type_account: 0)) # 0: open, 0: customer
    if @user.save 
      flash[:info] = "User created successfully"
      log_in(@user)
      redirect_to @user
    else
      flash[:error] = "An error has occurred"
      render 'new'
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Profile updated"
      redirect_to root_url
    else
      render "edit"
    end
  end


  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :image, :password_confirmation)
  end

  def correct_user
    return true if current_user.admin? 
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

end
