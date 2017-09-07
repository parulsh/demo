class PhotosController < ApplicationController

  def create
    @food = Food.find(params[:food_id])

    if params[:images]
      params[:images].each do |img|
        @food.photos.create(image: img)
      end

      @photos = @food.photos
      redirect_back(fallback_location: request.referer, notice: "Saved...")
    end
  end

  def destroy
    @photo = Photo.find(params[:id])
    @food = @photo.food

    @photo.destroy
    @photos = Photo.where(food_id: @food.id)

    respond_to :js
  end
end
