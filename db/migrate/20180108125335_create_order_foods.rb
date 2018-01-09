class CreateOrderFoods < ActiveRecord::Migration[5.0]
  def change
    create_table :order_foods do |t|
      t.integer :order_id
      t.integer :food_id
      t.float :price
      t.date :start_date
      t.date :end_date
      t.integer :quantity_per_day

      t.timestamps
    end
  end
end
