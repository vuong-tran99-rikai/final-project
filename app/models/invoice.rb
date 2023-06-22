class Invoice < ApplicationRecord
  belongs_to :user
  has_many :invoice_details
  has_many :books, through: :invoice_details
  enum status: {
    returned: 0,
    borrowed: 1
  }    

  validates :address, presence: true
  validates :phone, presence: true
  validates :expiry_date, presence: true
end
