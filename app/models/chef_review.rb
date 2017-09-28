class ChefReview < Review
  belongs_to :chef, class_name: "User"
end
