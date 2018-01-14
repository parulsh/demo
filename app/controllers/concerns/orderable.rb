module Orderable
  extend ActiveSupport::Concern

  def execute_stripe_payment
    begin
    token = Stripe::Token.create(:card => card_params )
      charge = Stripe::Charge.create({
        :amount => get_total_amount,
        :currency => "gbp",
        :source => token.id,
        :transfer_group => Time.current.strftime("%d%m%y%H%M%S"),
      })

      #save stripe charged token to orders table i.e. charge.id
      logger.info charge.id.inspect
      return charge
      
    rescue Stripe::CardError => e 
      flash.alert = e.message
      @error = e.message
      flash[:alert] = e.message
      redirect_to payment_method_path
    end
  end

  def get_sellers
    sellers = {}
    session[:cart_obj].each do |cart|
      food = Food.find cart.fetch("food_id")
      sellers[food.user_id] = 0 if sellers[food.user_id].nil?
      sellers[food.user_id] += cart.fetch("price")
    end
    return sellers
  end

  def execute_transfer_payment(charge_id, sellers)
    sellers.each do |id,price|
      begin
        user = User.find_by_id id
        transfer = Stripe::Transfer.create({
          :amount => (price*85).to_i,
          :currency => "gbp",
          :source_transaction => charge_id,
          :destination => user.get_account_id
        })
      rescue Stripe::CardError => e 
        flash.alert = e.message
        @error = e.message
        flash[:alert] = e.message
        redirect_to payment_method_path
      end
    end
  end

end