require 'date'
class Admin::DiscountsController < ApplicationController
    before_action :admin_user, only: [:new, :create, :update, :destroy, :show, :edit]
    def new
        @discounts = Discount.new
    end
    def create
        @discounts = Discount.new(discount_param)
        @discounts.status = params[:discount][:status].to_i
        if @discounts.save
            flash[:success] = t('flash.create')
            redirect_to request.referrer
        else
            flash[:danger] = t('flash.error')
            render :new
        end
    end

    def index
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
        flash[:success] = t('flash.delete')
        redirect_to request.referrer
    end
    def edit
        @discount = Discount.find_by(id: params[:id])
        unless @discount.present?
            flash[:danger] = t('flash.error')
            redirect_to request.referrer
        end
    end
    def update
        @discount = Discount.find(params[:id])
        # byebug
        if @discount.update(discount_param)
          flash[:success] =  t('flash.update')
          redirect_to request.referrer
        else
          flash[:danger] = t('flash.error')
          redirect_to request.referrer
        end
    end
    private
    
    def discount_param
        params.require(:discount).permit(:name_KM, :gia_KM, :start_day, :end_day)
    end
end
