FactoryBot.define do
  factory :recipe_food do
    recipe
    food

    # Ensure that both recipe and food belong to the same user
    after(:build) do |recipe_food|
      recipe_food.food.user = recipe_food.recipe.user if recipe_food.recipe && recipe_food.food
    end
  end
end
