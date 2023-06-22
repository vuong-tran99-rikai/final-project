module InvoicesHelper
  def calculate_total(cart)
    total = 0
    cart.each do |item|
      book = Book.find_by(id: item["book_id"])
      if book
        discounted_price = book.display_price[:discount]
        total += discounted_price * item["quantity"]
      end
    end
    total
  end

  def calculate_total_current(cart)
    total = 0
    cart.each do |item|
      # book = Book.find_by(item["book_id"])
      book = Book.find_by(id: item["book_id"])
      # price = book.price
      # total += price * item["quantity"]
      if book
        price = book.price
        total += price * item["quantity"]
      end
    end
    total
  end

  def get_cart_from_cookie
    JSON.parse(cookies[:cart]) if cookies[:cart]
  end

end