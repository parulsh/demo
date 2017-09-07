class OrdersController < ApplicationController
  before_action :authenticate_user!

  def create
    food = Food.find(params[:food_id])

  #  if current_user == food.user
  #    flash[:alert] = "You cannot order your own food!"
  #  else

    #  start_date = Date.parse(order_params[:start_date])



      @order = current_user.orders.build(order_params)
      @order.food = food
      @order.price = food.price
      @order.total = food.price * @order.portion_number
      @order.save

      flash[:notice] = "Your order has been placed!"

      redirect_to food
  end

  def portion_number

  end

  def your_orders
    @foods = current_user.foods
  end

  private
    def order_params
      params.require(:order).permit(:start_date, :user_id, :food_id, :portion_number)
    end
end
