require 'date'
class DiscountsController < ApplicationController
    before_action :admin_user, only: [:new, :create, :update, :destroy, :show, :edit]
    def new
        @discounts = Discount.new
    end
    def create
        @discounts = Discount.new(discount_param)
        @discounts.status = params[:discount][:status].to_i
        if @discounts.save
            flash[:success] = 'Đã tạo thành công Discount'
            redirect_to '/create-discounts'
        else
            flash[:danger] = 'vui lòng nhập thông tin'
            render :new
        end
    end

    def show
        @discounts = Discount.where(status: [0, 1])
        current_date = Date.current
        if(@discounts)
            @hihi = DiscountDetail
            @discounts = Discount.where(status: [0, 1]).order(:id)
            @discounts.each do |discount|
                if discount.start_day <= current_date && discount.end_day >= current_date
                    discount.status = 'Open'
                elsif  discount.end_day < current_date
                    discount.status = 'Close'
                else
                    discount.status = 'Close'
                end
                discount.save
            end
           
        else
            @discounts = []
        end
    end
    def destroy
        @discount = Discount.find(params[:id])
        @discount.status = 2
        @discount.save
        redirect_to '/discount'
    end
    def edit
        @discount = Discount.find_by(id: params[:id])
        unless @discount.present?
            redirect_to '/discount', flash: { danger: 'Không tồn tại' }
        end
    end
    def update
        @discount = Discount.find(params[:id])
        if @discount.update(discount_param)
          flash[:success] = 'Update thành công'
          redirect_to '/discount'
        else
          flash[:danger] = 'Category không tồn tại'
          redirect_to '/discount'
        end
    end
    private
    
    def discount_param
        params.require(:discount).permit(:name_KM, :gia_KM, :start_day, :end_day)
    end
end
