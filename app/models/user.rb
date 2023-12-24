class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :foods, dependent: :destroy
  has_many :recipes

  def missing_ingredients_for_recipes
    required_ingredients = RecipeFood.joins(:recipe).where(recipes: { user_id: id }).group(:food_id).sum(:quantity)
    user_stock = foods.index_by(&:id)

    missing_ingredients = []

    required_ingredients.each do |food_id, required_quantity|
      food = Food.find(food_id)
      stock_quantity = user_stock[food_id]&.quantity || 0

      if stock_quantity < required_quantity
        missing_quantity = required_quantity - stock_quantity
        missing_ingredients << { food:, missing_quantity: }
      end
    end

    missing_ingredients
  end
end
