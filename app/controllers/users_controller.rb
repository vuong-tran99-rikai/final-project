class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update, :show]
  before_action :admin_user, only: [:index]

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def edit 
    @user = User.find(params[:id])
  end

  def index
    @users = User.order(:id)
  end

  def create
    @user = User.new(user_params.merge!(status: 0, type_account: 0)) # 0: open, 0: customer
    if @user.save 
      flash[:info] = "User created successfully"
      log_in(@user)
      redirect_to root_url
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

  def destroy
    @user = User.find(params[:id]).deleted!
    flash[:success] = 'User deleted successfully'
    redirect_to users_url
  end

  def convert_status
    @user = User.find(params[:id])
    if @user.opened?
      @user.closed!
    elsif @user.closed?
      @user.opened!
    end
    redirect_to users_url
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def correct_user
    return true if current_user.admin? 
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

end
