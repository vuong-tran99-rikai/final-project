class InvoicesController < ApplicationController
  before_action :logged_in_user, only: [:new, :create]
  before_action :admin_user, only: [:revenue]


  def new
    @invoice = Invoice.new
    @cart = get_cart_from_cookie || []
  end

  def create
    @invoice = Invoice.new(invoice_params.merge!(status: 0))
    @cart = get_cart_from_cookie
    # byebug
    if @invoice.save
      flash[:info] = t('flash.book')
      cart.each do |item|
        book = Book.find_by(id: item["book_id"])
        if  book
          invoice_detail = InvoiceDetail.new(
            invoice_id: @invoice.id,
            book_id: item["book_id"],
            price: book.display_price[:discount],
            quantity: item["quantity"],
            status: 0,
          )
          book.update(quantity: book.quantity - item["quantity"])
          invoice_detail.save
        end
      end
      UserMailer.welcome_email(@invoice).deliver_now
      set_cart_cookie([])
      redirect_to root_url
    else
      flash[:error] = t('flash.error')
      render "new"
    end
  end

  # def index
  #   @invoices = current_user.invoices
  # end

  # def show
  #   @invoice = Invoice.find(params[:id])
  # end
  # def purchase_history
  #   @purchase_histories = Invoice.where(user_id: current_user.id)
  # end

  def add_to_cart
    book_id = params[:book_id]
    book = Book.find(book_id)
    cart = get_cart_from_cookie || []
    existing_item = cart.find { |item| item["book_id"] == book_id }

    if existing_item
      if existing_item["quantity"] >= book.quantity
        flash[:danger] = "Book not enough"
      else
        flash[:success] = t('flash.create')
        existing_item["quantity"] += 1
      end
    else
      flash[:success] = t('flash.create')
      cart << { "book_id" => book_id, "quantity" => 1 }
    end

    set_cart_cookie(cart)
    redirect_to request.referrer
  end
  
  def cart
    @cart = get_cart_from_cookie || []
  end

  def remove_item
    book_id = params[:book_id]
    @cart = get_cart_from_cookie || []
    @cart.delete_if { |item| item["book_id"] == book_id }
    set_cart_cookie(@cart)

    respond_to do |format|
      format.json { render json: { success: true } }
      format.html { redirect_to request.referrer }
      format.any { head :unsupported_media_type }
    end
  end

  def add_quantity
    book_id = params[:book_id]
    book = Book.find(book_id)
    @cart = get_cart_from_cookie || []
    item = @cart.find { |item| item["book_id"] == book_id }

    if item && item["quantity"] < book.quantity
      item["quantity"] += 1
      set_cart_cookie(@cart)
    end

    redirect_to cart_invoices_path
  end

  def reduce_quantity
    book_id = params[:book_id]
    @cart = get_cart_from_cookie || []
    item = @cart.find { |item| item["book_id"] == book_id }

    if item && item["quantity"] > 1
      item["quantity"] -= 1
      set_cart_cookie(@cart)
    elsif item
      @cart.delete(item)
      set_cart_cookie(@cart)
    end

    redirect_to cart_invoices_path  
  end
  


  def index
    @invoices = current_user.invoices
  end

  def show
    @invoice = Invoice.includes(invoice_details: [:book]).find(params[:id])

  end
  def purchase_history
    @purchase_histories = Invoice.where(user_id: current_user.id)
  end

  private

  def calculate_total_revenue(invoices)
    invoices.sum(&:total_price)
  end
  


  def invoice_params
    params.require(:invoice).permit(:phone, :address, :expiry_date, :total_discount, :total_price, :user_id)
  end

  def set_cart_cookie(cart)
    cookies[:cart] = JSON.generate(cart)
  end


end