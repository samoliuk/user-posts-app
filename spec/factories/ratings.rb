FactoryBot.define do
  sequence :value, (1..5).cycle do |i|
    i
  end

  factory :rating do
    value
    post
  end

  factory :best_rating, class: 'Rating' do
    value 5
    post
  end
end
