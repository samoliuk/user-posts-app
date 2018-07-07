class Post < ApplicationRecord
  belongs_to :user
  has_one :rating

  validates_presence_of :title, :body, :author_ip, :user_id
end
