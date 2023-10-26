class RecipesController < ApplicationController
  def index
    @recipes = current_user.recipes
  end

  def show
    @recipe = current_user.recipes.find(params[:id])
  end

  def new
    @recipe = current_user.recipes.new
  end

  def create
    @recipe = current_user.recipes.new(recipe_params)

    if @recipe.save
      redirect_to @recipe, notice: 'Recipe created successfully!'
    else
      render :new, notice: 'There was an error creating your recipe'
    end
  end

  def edit
  end

  def update
  end

  def destroy
    @recipe = current_user.recipes.find(params[:id])
    redirect_to recipes_path, notice: 'Recipe deleted successfully!' if @recipe.destroy
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public)
  end
end
