class PublicRecipesController < ApplicationController
  def index
    @recipes = Recipe.where(public: true).includes(:user).order(created_at: :desc)
  end
end
