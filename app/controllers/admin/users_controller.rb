class Admin::UsersController < ApplicationController
  before_action :admin_user, only: [:index, :convert_status, :destroy]
  def index
    @users = User.order(:id)
  end
  def convert_status
    @user = User.find(params[:id])
    if @user.opened?
      @user.closed!
    elsif @user.closed?
      @user.opened!
    end
    redirect_to request.referrer
  end
  def destroy
    @user = User.find(params[:id]).deleted!
    flash[:success] = t('flash.delete')
    redirect_to request.referrer
  end
end
