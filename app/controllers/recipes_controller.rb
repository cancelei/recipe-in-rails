class RecipesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def index
    @recipes = current_user.recipes.includes(recipe_foods: :food)
  end

  def show
    @recipe = current_user.recipes.includes(recipe_foods: :food).find(params[:id])
    @recipe_food = @recipe.recipe_foods.new
  end

  def new
    @recipe = current_user.recipes.new
  end

  def create
    @recipe = current_user.recipes.new(recipe_params)

    if @recipe.save
      redirect_to @recipe, notice: 'Recipe created successfully!'
    else
      flash[:notice] = 'There was an error creating your recipe'
      render :new
    end
  end

  def edit; end

  def update
    @recipe = Recipe.find(params[:id])
    if @recipe.update(recipe_params)
      redirect_to @recipe, notice: 'Recipe updated successfully!'
    else
      render :edit
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.recipe_foods.destroy_all # This will destroy all associated recipe_foods records
    @recipe.destroy
    redirect_to recipes_path, notice: 'Recipe deleted successfully!'
  end

  def generate_shopping_list
    missing_ingredients_data = current_user.missing_ingredients_for_recipes
    @missing_ingredients = missing_ingredients_data.map { |data| data[:food] }
    @total_price = missing_ingredients_data.sum { |data| data[:missing_quantity] * data[:food].price }
    render :shopping_list
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public)
  end

  def record_not_found
    redirect_to recipes_path, alert: 'Recipe not found'
  end
end
