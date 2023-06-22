class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.string :name_book
      t.string :description
      t.string :author
      t.integer :quantity
      t.integer :price 
      t.string  :image
      t.bigserial :category_id
      t.integer :status
      t.timestamps
    end   
  end
end
