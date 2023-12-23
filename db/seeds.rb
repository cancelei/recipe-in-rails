# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Creating Users with Devise
user1 = User.create!(name: "Alice", email: "alice@example.com", password: "password123", password_confirmation: "password123")
user2 = User.create!(name: "Bob", email: "bob@example.com", password: "password456", password_confirmation: "password456")

# Creating Foods
food1 = Food.create(name: "Tomato", measurement_unit: "kg", price: 2.50, quantity: 10, user: user1)
food2 = Food.create(name: "Potato", measurement_unit: "kg", price: 1.50, quantity: 20, user: user2)

# Creating Recipes
recipe1 = Recipe.create(name: "Tomato Soup", preparation_time: 30, cooking_time: 15, description: "Delicious tomato soup.", public: true, user: user1)
recipe2 = Recipe.create(name: "Baked Potato", preparation_time: 10, cooking_time: 45, description: "Crispy baked potatoes.", public: true, user: user2)

# Creating RecipeFoods
RecipeFood.create(quantity: 5, recipe: recipe1, food: food1)
RecipeFood.create(quantity: 3, recipe: recipe2, food: food2)
