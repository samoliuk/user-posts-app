# require 'activerecord-import'
#
# if Rails.env.development?
#   include FactoryBot::Syntax::Methods
#
#   users = []
#
#   (0..100).each do |i|
#     u = User.new(login: "my_user_#{i}")
#
#     (1..(i+10)).each do |j|
#       u.posts.build(attributes_for(:post).merge(rating: Rating.new(value: rand(1..5))))
#     end
#
#     (i+11..(i+2000)).each do |j|
#       u.posts.build(attributes_for(:post))
#     end
#
#     users << u
#   end
#
#   User.import users, recursive: true
# end
