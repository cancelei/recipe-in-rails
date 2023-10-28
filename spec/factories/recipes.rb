FactoryBot.define do
  factory :recipe do
    name { Faker::Food.dish }
    preparation_time { rand(5..120) } # Randomly assign a preparation time between 5 and 120 minutes
    cooking_time { rand(10..240) } # Randomly assign a cooking time between 10 and 240 minutes
    description { Faker::Food.description }
    public { [true, false].sample }
    user { association(:user) }

    # If you wish to create a recipe with associated foods, you can add a trait:
    trait :with_foods do
      after(:create) do |recipe|
        3.times do
          food = create(:food, user: recipe.user) # ensuring the food belongs to the same user
          create(:recipe_food, recipe:, food:)
        end
      end
    end
  end
end
