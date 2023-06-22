class Admin::BooksController < ApplicationController
  before_action :admin_user, only: [:new, :create, :update, :destroy, :index, :toggle_status_book, :edit]

  protect_from_forgery with: :exception

  def new
    @books = Book.new
  end

  def create
    @books = Book.new(book_params)
    @books.status = params[:book][:status].to_i

    if @books.save
      flash[:success] = t('flash.create')
      redirect_to request.referrer
    else
      flash[:danger] = t.('flash.error')
      render :new
    end
  end

  def index
    if params[:search].present?
      @books = Book.where("LOWER(name_book) LIKE ?", "%#{params[:search].downcase}%")
                   .where(status: [0, 1])
                   .includes(:category)
                   .order(:id)
    else
      @books = Book.where(status: [0, 1]).includes(:category)
                   .order(:id)
    end
  end

  def toggle_status
    @books = Book.find(params[:id])
    if @books.Close?
      @books.status = "Open"
    elsif @books.Open?
      @books.status = "Close"
    end
    @books.save
    redirect_to request.referrer
  end

  def destroy
    @books = Book.find(params[:id])
    @books.status = 2
    @books.save
    redirect_to request.referrer
  end

  def edit
    @books = Book.where(status: [0, 1]).find(params[:id])
  end

  def update
    @books = Book.find(params[:id])
    if @books.update(book_params)
      flash[:success] = t('flash.update')
      redirect_to request.referrer
    else
      flash[:danger] = t('flash.error')
      redirect_to request.referrer
    end
  end

# def search_book
#   @books = Book.where("LOWER(name_book) LIKE ?", "%#{params[:search].downcase}%").includes(:category)

#   redirect_to admin_books_path
# end

  private

  def book_params
    params.require(:book).permit(:name_book, :description, :author, :quantity, :price, :image, :category_id)
  end
end
