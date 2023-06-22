class CreateDiscounts < ActiveRecord::Migration[6.1]
  def change
    create_table :discounts do |t|
      t.string :name_KM
      t.float :gia_KM
      t.date :start_day
      t.date :end_day
      t.integer :status
      t.timestamps
    end
  end
end
