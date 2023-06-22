class CreateInvoiceDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :invoice_details do |t|
      t.integer :invoice_id
      t.integer :book_id
      t.float :price
      t.integer :quantity
      t.integer :status
      t.timestamps
    end
  end
end
