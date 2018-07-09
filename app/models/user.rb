class User < ApplicationRecord
  has_many :posts

  validates :login, presence: true
end
