FactoryBot.define do
  sequence :title do |i|
    "Post #{i}"
  end

  sequence :author_ip, (10..255).cycle do |i|
    "10.0.0.#{i}"
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
end
