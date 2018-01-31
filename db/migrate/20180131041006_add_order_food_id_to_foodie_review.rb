class AddOrderFoodIdToFoodieReview < ActiveRecord::Migration[5.0]
  def change
    add_column :reviews, :order_food_id, :integer
  end
end
