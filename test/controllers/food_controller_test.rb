require 'test_helper'

class FoodControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get food_index_url
    assert_response :success
  end

  test "should get new" do
    get food_new_url
    assert_response :success
  end

  test "should get create" do
    get food_create_url
    assert_response :success
  end

  test "should get listing" do
    get food_listing_url
    assert_response :success
  end

  test "should get pricing" do
    get food_pricing_url
    assert_response :success
  end

  test "should get description" do
    get food_description_url
    assert_response :success
  end

  test "should get photo_upload" do
    get food_photo_upload_url
    assert_response :success
  end

  test "should get ingredients" do
    get food_ingredients_url
    assert_response :success
  end

  test "should get location" do
    get food_location_url
    assert_response :success
  end

  test "should get update" do
    get food_update_url
    assert_response :success
  end

end
