require 'uri'

class Book < ApplicationRecord
    belongs_to :category
    has_many :invoice_details
    has_many :invoice, through: :invoice_details
    has_many :discount_details, foreign_key: :book_id
    has_many :discounts, through: :discount_details, foreign_key: :discount_id
    has_many :votes
    validates :name_book, presence: true
    validates :description, presence: true
    validates :image, presence: true
    mount_uploader :image, ImageUploader
    validates :author, presence: true
    validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 0 }
    validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
    validates :category_id, presence: true
    enum status: { 'Close': 0, 'Open': 1, delete_category: 2 }
    attribute :name_book, :string

    def display_price
      discount = discounts.Open.first
      if discount.present?
        return {
          current: price,
          discount: price - (price * discount.gia_KM / 100)
        }
      end

      {
        current: '',
        discount: price
      }
        # discounts.each do |discount|
        #   if discount.Open? 
        #     return {
        #       current: price,
        #       discount: price - (price * discount.gia_KM / 100)
        #     }
        #   end
        # end
        # return {
        #   current: '',
        #   discount: price
        # }
    end
end
