FactoryBot.define do
  sequence :title do |i|
    "Post #{i}"
  end

  sequence :author_ip, (10..60).cycle do |i|
    "10.0.0.#{i}"
  end

  sequence :avg_rating, (1..5).cycle do |i|
    i.to_f
  end

  factory :post do
    title
    body 'Post Body'
    author_ip
    user
  end

  factory :invalid_post, class: 'Post' do
    title nil
    body nil
    author_ip nil
  end

  factory :rated_post, class: 'Post' do
    title
    body 'Post Body'
    author_ip
    avg_rating
    user
  end
end
