class Admin::RentalhistorysController < ApplicationController
    def index
        @history = Invoice.joins(:user).where(status: 0).select('invoices.*, users.name').order(:id)
      end
      def toggle_status
        @invoice = Invoice.find(params[:id])
        @invoice.invoice_details.each do |invoice_detail|
          book_id = invoice_detail.book_id
          quantity = invoice_detail.quantity
          
          # Cập nhật số lượng sách trong Book
          book = Book.find(book_id)
          book.quantity += quantity
          book.save
        end

        # Cập nhật trạng thái của Invoice thành "borrowed"
        @invoice.status = :borrowed
        @invoice.save
        flash[:success] = t('flash.returned')
        redirect_to request.referrer
      end
      def show
        @invoice = Invoice.find(params[:id])
        @history = @invoice.invoice_details.includes([:book])
        # byebug
      end
end
