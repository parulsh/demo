class OrdersController < ApplicationController
  before_action :authenticate_user!

  def create
    food = Food.find(params[:food_id])

    if current_user == food.user
        flash[:alert] = "You cannot book your own property!"
      else
        start_date = Date.parse(order_params[:start_date])
        end_date = Date.parse(order_params[:end_date])
        days = (end_date - start_date).to_i + 1


      @order = current_user.orders.build(order_params)
      @order.food = food
      @order.price = food.price
      @order.total = food.price * days
       #@order.save

      if @order.save
        if food.Request?
          flash[:notice] = "Request sent succesfully"
        else
          @order.Approved!
          flash[:notice] = "Your order was created succesfully"
        end
      else
        flash[:alert] = "Cannot complete your order"
      end

    end

      redirect_to food
  end

  def portion_number

  end

  def your_meals
    @meals = current_user.orders.order(start_date: :asc)
  end

  def your_orders
    @foods = current_user.foods

  end

  private
    def order_params
      params.require(:order).permit(:start_date, :end_date)
    end
end
