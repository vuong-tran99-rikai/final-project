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
    validates :image, format: { with: URI::regexp(%w(http https)), message: "must be a valid image URL" }
    validates :author, presence: true
    validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 0 }
    validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
    validates :category_id, presence: true
    enum status: { 'Tạm tắt': 0, 'Hiển thị': 1, delete_book: 2, daxoa: 3 }
    attribute :name_book, :string

    def display_price
        discounts.each do |discount|
            if discount.Open? 
                return last_price = {
                    current: price,
                    discount: price - (price * discount.gia_KM / 100)
                }
            end
        end
        return last_price = {
            current: '',
            discount: price
        }
    end
end
