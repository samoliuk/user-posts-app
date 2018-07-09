FactoryBot.define do
  factory :post do
    title 'Post 1'
    body 'Post 1 Body'
    author_ip '10.0.0.10'
    user
  end

  factory :invalid_post, class: 'Post' do
    title nil
    body nil
    author_ip nil
  end
end
