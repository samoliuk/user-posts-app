class Rating < ApplicationRecord
  belongs_to :post

  validates_presence_of :value, :post_id
end
