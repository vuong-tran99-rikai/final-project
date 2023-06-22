class DiscountDetail < ApplicationRecord
    belongs_to :book
    belongs_to :discount
    validates :book_id, presence: true
end
