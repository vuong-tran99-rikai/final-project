class Admin::InvoicesController < ApplicationController
    def revenue
        if params[:search_month].present?
          year, month = params[:search_month].split("-")
          @invoices = Invoice.includes(:user).where("EXTRACT(MONTH FROM created_at) = ? AND EXTRACT(YEAR FROM created_at) = ?", month.to_i, year.to_i)
        else
          @invoices = Invoice.includes(:user)
        end
    
        @total_revenue = calculate_total_revenue(@invoices)
      end

      private

      def calculate_total_revenue(invoices)
        invoices.sum(&:total_price)
      end
end