class AddForeignKeyToInvoices < ActiveRecord::Migration[6.1]
  def change
    add_foreign_key :invoices, :users, column: :user_id
  end
end
