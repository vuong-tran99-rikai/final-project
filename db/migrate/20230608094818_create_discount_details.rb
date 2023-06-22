class CreateDiscountDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :discount_details do |t|
      t.bigserial :book_id
      t.timestamps
    end
    add_column :discount_details, :discount_id, :bigserial
    add_foreign_key :discount_details, :books, column: :book_id
    add_foreign_key :discount_details, :discounts, column: :discount_id
  end
end
