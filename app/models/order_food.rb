class OrderFood < ApplicationRecord
  belongs_to :food
  belongs_to :order

  def is_reviewed?
  	FoodieReview.where( order_food_id: id).present? rescue false
  end

  def get_reviews
  	FoodieReview.where( order_food_id: id).first.star rescue 0
  end

  def chef_reviewed?
  	ChefReview.where( order_food_id: id).present? rescue false
  end

  def get_chef_reviewed
  	ChefReview.where( order_food_id: id).first.star rescue 0
  end
end
