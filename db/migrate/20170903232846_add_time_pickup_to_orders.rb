class AddTimePickupToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :time_pickup, :time
  end
end
