# spec/factories/foods.rb
FactoryBot.define do
  factory :food do
    association :user
    name { Faker::Food.ingredient }
    measurement_unit { ["grams", "liters", "pieces"].sample }
    price { Faker::Commerce.price(range: 0.1..10.0) } # generates a price between 0.1 and 10.0
    quantity { rand(1..100) } # generates a random integer between 1 and 100

    # Ensuring uniqueness of name scoped to user
    after(:create) do |food|
      food.name = "#{food.name} #{food.id}"
      food.save
    end
  end
end
