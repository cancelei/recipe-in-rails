class RecipeFoodsController < ApplicationController
  before_action :set_recipe
  # Create a new ingredient association for a recipe
  def create
    @recipe_food = @recipe.recipe_foods.build(recipe_food_params)
    if @recipe_food.save
      flash[:notice] = 'Ingredient added successfully.'
      redirect_to @recipe
    else
      flash[:alert] = 'Failed to add ingredient.'
      render 'recipes/show'
    end
  end

  # Remove an ingredient association from a recipe
  def destroy
    @recipe_food = @recipe.recipe_foods.find(params[:id])
    if @recipe_food.destroy
      flash[:notice] = 'Ingredient removed successfully.'
      redirect_to @recipe
    else
      flash[:alert] = 'Failed to remove ingredient.'
      render 'recipes/show'
    end
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:recipe_id])
  end

  def recipe_food_params
    params.require(:recipe_food).permit(:food_id, :quantity)
  end
end
