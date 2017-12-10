class OrdersController < ApplicationController
  before_action :authenticate_user!, except: [:cart, :my_cart]
  before_action :set_order, only: [:approve, :decline]

  def create
    food = Food.find(params[:food_id])

    if current_user == food.user
        flash[:alert] = "You cannot order your own food :("
      else
        start_date = Date.parse(order_params[:start_date])
        end_date = Date.parse(order_params[:end_date])
        days = (end_date - start_date).to_i + 1


      @order = current_user.orders.build(order_params)
      @order.food = food
      @order.price = food.price
      @order.total = food.price * days
      @order.save

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

  def cart 
    session[:cart_obj] = Array.new if !session[:cart_obj] 

    logger.info session[:cart_obj].inspect
    logger.info params[:food_id].inspect

    if params[:food_id].present?
      food = Food.find params[:food_id].to_i

      position = nil
      quantity = 1  

      start_date = Date.strptime(params[:order][:start_date], '%m/%d/%Y')
      end_date = Date.strptime(params[:order][:end_date], '%m/%d/%Y')

      days = end_date.mjd - start_date.mjd

      total_quantity = (params[:quantity].to_i * days.to_i) if params[:quantity] && params[:quantity].to_i > 0
      day_qty = params[:quantity].to_i
 

      if food 
        if session[:cart_obj].size > 0  
          session[:cart_obj].each_with_index do |d, index|
            if d[:id] == food.id
              position = index   
            end
          end  
          unless position.nil?  
            session[:cart_obj][position][:total_quantity] = session[:cart_obj][position][:total_quantity].to_i + total_quantity
   
            session[:cart_obj][position][:day_qty] = day_qty.to_i
            session[:cart_obj][position][:price] = (product.price.to_f/100 * qty) 
            session[:cart_obj][position][:unit_price] = product.price.to_f/100 
          else 
            h = { :name =>food.listing_name, :start_date => start_date, :end_date=> end_date, :food_id=>params[:food_id].to_i, :unit_price=>food.price.to_f, :total_quantity => total_quantity, :per_day_qty=> day_qty, :price=> food.price.to_f * total_quantity.to_i }                
            session[:cart_obj] << h 
          end 
        else
          h = {:name => food.listing_name, :start_date => start_date, :end_date=> end_date, :food_id => params[:food_id].to_i, :unit_price=>food.price.to_f, :total_quantity => total_quantity, :per_day_qty=> day_qty, :price=> food.price.to_f * total_quantity.to_i }                
          session[:cart_obj] << h 
        end 
      end 
    end
  end

  def my_cart
    logger.info session[:cart_obj].inspect
    
  end

  def portion_number

  end

  def your_meals
    @meals = current_user.orders.order(start_date: :asc)
  end

  def your_orders
    @foods = current_user.foods

  end

  def approve
      @order.Approved!
    redirect_to your_orders_path
  end

  def decline
    @order.Declined!
    redirect_to your_orders_path
  end


  private

    def set_order
        @order = Order.find(params[:id])
      end

    def order_params
      params.require(:order).permit(:start_date, :end_date)
    end
end
