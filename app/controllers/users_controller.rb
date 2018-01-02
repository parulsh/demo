class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show]

  def show
    @user = User.find(params[:id])
    @foods = @user.foods

    # Displays all the foodie's reviews to the chef (If this user is a chef)
    @foodie_reviews = Review.where(type: "FoodieReview", chef_id: @user.id)

    # Displays all the chef's reviews to the chef (If this user is a foodie)
    @chef_reviews = Review.where(type: "ChefReview", foodie_id: @user.id)

  end

  def update_phone_number
    current_user.update_attributes(user_params)
    current_user.generate_pin
    current_user.send_pin

    redirect_to edit_user_registration_path, notice: "Saved..."
  rescue Exception => e
    redirect_to edit_user_registration_path, alert: "#{e.message}"
  end

  def verify_phone_number
    current_user.verify_pin(params[:user][:pin])

    if current_user.phone_verified
      flash[:notice] = "Your phone number is verified."
    else
      flash[:alert] = "Cannot verify your phone number."
    end

    redirect_to edit_user_registration_path

  rescue Exception => e
    redirect_to edit_user_registration_path, alert: "#{e.message}"
  end

  def payment
  end

  def payout
    if !current_user.merchant_id.blank?
      account = Stripe::Account.retrieve(current_user.merchant_id)
      @login_link = account.login_links.create()
    end
end

def add_card

  
  if current_user.stripe_id.blank?
    customer = Stripe::Customer.create(
      email: current_user.email
    )
    current_user.stripe_id = customer.id
    current_user.save
  else
    customer = Stripe::Customer.retrieve(current_user.stripe_id)
  end


  month, year = params[:expiry].split(/ \/ /)
  new_token = Stripe::Token.create(:card => {
      :number => params[:number],
      :exp_month => month,
      :exp_year => year,
      :cvc => params[:cvv]

    })
    customer.sources.create(source: new_token.id)

    flash[:notice] = "Your card is saved."
    redirect_to payment_method_path
rescue Stripe::CardError => e
    flash[:alert] = e.message
    redirect_to payment_method_path
end


def process_payment 
  customer = nil
  if current_user.stripe_id.blank?
    customer = Stripe::Customer.create(
      email: current_user.email
    )
    current_user.stripe_id = customer.id
    current_user.save 
  else
    customer = Stripe::Customer.retrieve(current_user.stripe_id)
  end  

  exp_string = params[:card][:expiry].split("/") rescue [] 
  exp_month = exp_string[0] rescue ''
  exp_year = exp_string[1] rescue ''
  @error = ""
  begin
    new_token = Stripe::Token.create(:card => {
      :number => params[:card][:number],
      :exp_month => exp_month,
      :exp_year => exp_year,
      :cvc => params[:card][:cvv]

    })
    customer.sources.create(source: new_token.id)   
    rescue Stripe::CardError => e 

      flash.alert = e.message
      @error = e.message
    end

    if @error.blank?
      begin
        # Charge the customer's card:
        Stripe::Charge.create(
        :amount => get_total_amount,       
        :currency => "usd",
<<<<<<< HEAD
        :source => customer.default_source,  
        :description => "food payment"
      ) 
=======
        :description => "food payment",
        card: {name: params[:card][:name], number:params[:card][:number], cvc: params[:card][:cvv],
              exp_month: params[:card][:exp_month], exp_year:params[:card][:exp_year]}
      )

      # save this in db for future reference
      logger.info charge.id

    rescue Stripe::CardError => e
      flash.alert = e.message
      @error = e.message
    end

    logger.info @error.inspect
    if @error == ""
      session[:cart_obj] = nil
    end

end

  def thanks

  end


def process_payment
  @error = ""
    begin
      # Charge the customer's card:
      charge = Stripe::Charge.create(
        :amount => get_total_amount,
        :currency => "usd",
        :description => "food payment",
        card: {name: params[:card][:name], number:params[:card][:number], cvc: params[:card][:cvv],
              exp_month: params[:card][:exp_month], exp_year:params[:card][:exp_year]}
      )

      # save this in db for future reference
      logger.info charge.id

    rescue Stripe::CardError => e
      flash.alert = e.message
      @error = e.message
    end
>>>>>>> 62f685dcebcd06779f1f74b203f754f086f8a41f

      rescue Stripe::CardError => e 
        flash.alert = e.message
        @error = e.message
      end

      logger.info @error.inspect
      if @error == ""
        session[:cart_obj] = nil
      end
    end 
  end

  def thanks

  end
 

  private


    def get_total_amount
    sub_total = 0
    if session[:cart_obj] && session[:cart_obj].size > 0
      session[:cart_obj].each do |d|
        sub_total += d.fetch("price").to_f
      end
    end
    return (sub_total*100).to_i
  end

    def user_params
      params.require(:user).permit(:phone_number, :pin)
    end
end
