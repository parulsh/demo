class Food < ApplicationRecord
  enum instant: {Request: 0, Instant: 1}


  belongs_to :user
  has_many :photos
  has_many :orders

  has_many :foodie_reviews

  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  validates :cuisine_type, presence: true
  validates :entree_type, presence: true
  validates :portions_available, presence: true

  def cover_photo(size)
    if self.photos.length > 0
      self.photos[0].image.url(size)
    else
      "blank.jpg"
    end
  end

  def average_rating
    foodie_reviews.count == 0 ? 0 : foodie_reviews.average(:star).round(2).to_i
  end

end
