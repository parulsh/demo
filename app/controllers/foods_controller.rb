class FoodsController < ApplicationController
  before_action :set_food, except: [:index, :new, :create]
  before_action :authenticate_user!, except: [:show]
  before_action :is_authorised, only: [:listing, :pricing, :description, :photo_upload, :ingredients, :diets, :location, :update]
  def index
    @foods = current_user.foods
  end

  def new
    @food = current_user.foods.build
  end

  def create
      @food = current_user.foods.build(food_params)
      if @food.save
        redirect_to listing_food_path(@food), notice: "Saved..."
      else
       flash[:alert] = "You need to select one option on each category..."
       render :new
      end
  end

  def show
    @photos = @food.photos
  end

  def listing
  end

  def pricing
  end

  def description
  end

  def photo_upload
    @photos = @food.photos
  end

  def ingredients
  end

  def diets
  end

  def location
  end

  def update

    new_params = food_params
    new_params = food_params.merge(active: true) if is_ready_food


    if @food.update(new_params)
      flash[:notice] = "Saved..."
    else
      flash[:notice] = "Something went wrong..."

    end
    redirect_back(fallback_location: request.referer)
  end

  #---Orders---

  def preload

    orders = @food.orders.where("portion_number" <= @foods.portions_available)

    render json: orders

  end

  def preview

    #start_date = Date.parse(params)[:start_date]

  #  output = {
  #    conflict: is_conflict(portions_available, @food)
  #  }

  #  render json: output

  end


  private

    #def is_conflict(portions_available, food)
    #  check = food.orders.where("? > portions_available", portions_available)
    #  check.size > portions_available ? true : false
    #end


   def set_food
    @food = Food.find(params[:id])
   end

   def is_authorised
     redirect_to root_path, alert: "You don't have permission" unless current_user.id == @food.user_id
  end

  def is_ready_food
   !@food.active && !@food.price.blank? && !@food.listing_name.blank? && !@food.photos.blank? && !@food.address.blank?
  end

   def food_params
     params.require(:food).permit(:cuisine_type, :entree_type, :portions_available, :listing_name, :summary, :address, :price,
      :organic, :vegan, :vegetarian, :gluten_free, :other_diets, :milk, :eggs, :chicken, :redmeat, :fish, :other, :active)

  end
end