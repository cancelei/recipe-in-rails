class DashboardController < ApplicationController
  def index
    @recipes = Recipe.includes(:user).order(created_at: :desc).limit(10)
  end
end
