class PagesController < ApplicationController
  def home
    @category = Category.where(status: 1)
    @user = current_user
    if params[:search].present?
      @books = Book.where("LOWER(name_book) LIKE ?", "%#{params[:search].downcase}%")
                   .where(status: 1)
                   .order(:id)

    elsif params[:category_id].present?
      @books = Book.joins(:category)
                   .where(categories: { id: params[:category_id], status: 1 })
                   .where(status: 1)
                   .order(:id)
    else
      @books = Book.where(status: 1)
                   .order(:id)
    end
  end

  def show
    @book = Book.find(params[:id])
    @evaluaters = Evaluater.where(book_id: @book.id).includes(:user)
  end
end
