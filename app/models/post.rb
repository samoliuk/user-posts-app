class Post < ApplicationRecord
  belongs_to :user
  has_one :rating

  validates :title, :body, :author_ip, :user_id, presence: true
end
