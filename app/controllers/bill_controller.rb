class BillController < ApplicationController
  

  private

  def get_cart_from_cookie
    JSON.parse(cookies[:cart]) if cookies[:cart]
  end
end
