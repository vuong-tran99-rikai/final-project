class EvaluatersController < ApplicationController
  before_action :admin_user, only: [:index]
  before_action :logged_in_user, only: [:new, :create]

  def new
    @evaluater = Evaluater.new
    @book = Book.find(params[:id])
  end

  def create
    @evaluater = Evaluater.new(evaluater_params)
    @book = Book.find(params[:evaluater][:book_id])
    if @evaluater.save
      flash[:success] = "Đã thêm mới đánh giá"
      redirect_to detail_path(@book)
    else
      render :new
    end
  end

  def index
    @evaluaters = Evaluater.includes([:book,:user])
  end

  private

  def evaluater_params
    params.require(:evaluater).permit(:book_id, :level, :comment, :user_id)
  end
end
