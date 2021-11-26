FactoryBot.define do
  factory :post do
    caption { Faker::Lorem.characters(number: 20) }
    user
  end
end
