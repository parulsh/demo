class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @foods = @user.foods

    # Displays all the foodie's reviews to the chef (If this user is a chef)
    @foodie_reviews = Review.where(type: "FoodieReview", chef_id: @user.id)

    # Displays all the chef's reviews to the chef (If this user is a foodie)
    @chef_reviews = Review.where(type: "ChefReview", foodie_id: @user.id)

  end
end
