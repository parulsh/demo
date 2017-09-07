class AddPortionNumberToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :portion_number, :integer
  end
end
