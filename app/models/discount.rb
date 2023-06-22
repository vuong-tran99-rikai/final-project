require 'validates_timeliness'
class Discount < ApplicationRecord
    has_many :discount_detail
    has_many :books, through: :discount_detail
    validates :name_KM, presence: true, uniqueness: { scope: [:status], conditions: -> { where(status: [0, 1]) } }
    validates_datetime :start_day, presence: true, on_or_after: -> { Date.current }, message: I18n.t('flash.error'), on: :create
    validates_datetime :end_day, presence: true, after: :start_day, message: I18n.t('flash.error'), on: :create
    validates :gia_KM, presence: true, numericality: { less_than_or_equal_to: 100 }
    enum status: { 'Close': 0, 'Open': 1, delete_category: 2 }
end
