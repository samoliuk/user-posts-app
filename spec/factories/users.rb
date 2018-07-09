FactoryBot.define do
  sequence :login do |i|
    "my_user_#{i}"
  end

  factory :user do
    login
  end
end
