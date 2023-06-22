class InvoiceDetail < ApplicationRecord
    belongs_to :book
    belongs_to :invoice
end
