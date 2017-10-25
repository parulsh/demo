class UsersController < ApplicationController
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

  private

    def user_params
      params.require(:user).permit(:phone_number, :pin)
    end
end
