class ChefReviewsController < ApplicationController

  def create
    # Step 1: Check if the reservation exists (food_id, foodie_id, chef_id)

    # Step 2: Check if the current chef already reviewed the guest in this reservation.

    # @order = Order.where(
    #                 id: chef_review_params[:order_id],
    #                 food_id: chef_review_params[:food_id],
    #                 user_id: chef_review_params[:foodie_id]
    #                ).first
    
    @order_food = OrderFood.find_by_id(chef_review_params[:order_food_id])

    if !@order_food.nil?

      @has_reviewed = ChefReview.where(
                        order_food_id: @order_food.id,
                        # order_id: @order.id,
                        foodie_id: chef_review_params[:foodie_id]
                      ).first

      if @has_reviewed.nil?
          # Allow to review
          @chef_review = current_user.chef_reviews.create(chef_review_params)
          flash[:success] = "Your Review was created..."
      else
          # Already reviewed
          flash[:success] = "You already reviewed this Order"
      end
    else
      flash[:alert] = "Not found this reservation"
    end

    redirect_back(fallback_location: request.referer)
  end

  def destroy
    @chef_review = Review.find(params[:id])
    @chef_review.destroy

    redirect_back(fallback_location: request.referer, notice: "Removed...!")
  end

  private
    def chef_review_params
      params.require(:chef_review).permit(:comment, :star, :food_id, :order_id, :foodie_id, :order_food_id)
    end
end
