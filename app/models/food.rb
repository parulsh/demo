class Food < ApplicationRecord
  belongs_to :user
  has_many :photos
  has_many :orders 

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

end
