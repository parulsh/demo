class FoodieReview < Review
  belongs_to :foodie, class_name: "User"
end
