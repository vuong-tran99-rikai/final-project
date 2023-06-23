class EvaluatersController < ApplicationController
  before_action :logged_in_user, only: [:show, :create]

  def show
    @evaluater = Evaluater.new
    @book = Book.find(params[:id])
  end

  def create
    @evaluater = Evaluater.new(evaluater_params)
    @book = Book.find(params[:evaluater][:book_id])
    if @evaluater.save
      flash[:success] = t('flash.create')
      redirect_to page_path(@book.id)
    else
      render :new
    end
  end

  # def index
  #   @evaluaters = Evaluater.includes([:book]).includes([:user])
  # end

  private

  def evaluater_params
    params.require(:evaluater).permit(:book_id, :level, :comment, :user_id)
  end
end
