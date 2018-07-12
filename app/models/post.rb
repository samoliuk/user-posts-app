class Post < ApplicationRecord
  include Scopable
  
  belongs_to :user
  has_many :ratings, dependent: :destroy

  def update_average_rating
    avg_rating = Rating.where(post: self).average(:value)
    update_attribute(:avg_rating, avg_rating)
  end
end
