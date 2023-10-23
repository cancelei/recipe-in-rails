class DashboardController < ApplicationController
  def index
    @recipes = Recipe.all.limit(10) # Display the latest 10 recipes for simplicity.
  end
end
