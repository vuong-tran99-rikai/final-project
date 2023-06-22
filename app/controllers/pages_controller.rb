class PagesController < ApplicationController
  def home
    if params[:search].present?
      @books = Book.where("name_book LIKE ?", "%#{params[:search]}%")
             .where(status: 1)
             .includes(:discounts)
             .order(:id)
      # @books = Book.where("LOWER(name_book) LIKE ?", "%#{params[:search].downcase}%").where(status: 1).order(:id)
      @category = Category.where(status: 1)
    else
      @category = Category.where(status: 1)
      @books = Book.includes(:discounts).where(status: 1).order(:id)
    end
  end
  

  def show
    @book = Book.find(params[:id])
    @evaluaters = Evaluater.where(book_id: @book.id).includes(:user)
  end

  def cart
    @cart = session[:cart]
  end

  def create
    
  end

  def add_item
    @book = Book.find(params[:id])
    redirect_to root_url
    # byebug
  end
end
