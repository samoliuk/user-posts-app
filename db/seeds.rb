include FactoryBot::Syntax::Methods

users = create_list(:user, 100)
users.each_with_index do |u, i|
  puts "working with user #{i}"
  (i+1951).times do |j|
    p = PostService.new(attributes_for(:post).merge(user_login: u.login)).call

    # rate every 100 post
    if j % 100 == 0
      # 1 to 10 rates
      rand(1..10).times do
        RatingService.new(attributes_for(:rating).merge(post_id: p.id)).call
      end
    end
  end
end
