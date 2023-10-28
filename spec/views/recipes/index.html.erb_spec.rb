require 'rails_helper'

RSpec.describe 'recipes/index.html.erb', type: :view do
  before do
    # Assuming you have a Recipe factory and you're using FactoryBot
    @recipes = FactoryBot.create_list(:recipe, 3)
    assign(:recipes, @recipes)
  end

  it "displays all the recipes" do
    render

    @recipes.each do |recipe|
      expect(rendered).to have_content(recipe.name)
      # Add other attributes to check for if necessary, like:
      # expect(rendered).to have_content(recipe.description)
    end
  end

  it "provides a link to each recipe's show page" do
    render

    @recipes.each do |recipe|
      expect(rendered).to have_link(recipe.name, href: recipe_path(recipe))
    end
  end

  it "has a link to create a new recipe" do
    render
    expect(rendered).to have_link('Create new recipe', href: new_recipe_path)
  end

  # Add any other assertions you think are necessary.
end
