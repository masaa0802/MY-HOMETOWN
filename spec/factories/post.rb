FactoryBot.define do
  factory :post do
    video   {'video'}
    caption { Faker::Lorem.characters(number: 20) }
    user
  end
end