class CreateEvaluaters < ActiveRecord::Migration[6.1]
  def change
    create_table :evaluaters do |t|
      t.integer :book_id
      t.integer :level
      t.integer :user_id
      t.string  :comment
      t.timestamps
    end

    add_foreign_key :evaluaters, :books , column: :book_id
    add_foreign_key :evaluaters, :users , column: :user_id
  end
end
