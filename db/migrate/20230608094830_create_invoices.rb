class CreateInvoices < ActiveRecord::Migration[6.1]
  def change
    create_table :invoices do |t|
      t.integer :user_id
      t.string :address
      t.string :phone
      t.integer :status
      t.float :total_price
      t.float :total_discount
      t.date :expiry_date
      t.integer :payment_method
      t.timestamps
    end
  end
end
