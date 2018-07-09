class Rating < ApplicationRecord
  belongs_to :post

  validates :value, presence: true, inclusion: 1..5
  validates :post_id, presence: true
end
