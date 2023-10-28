require 'rails_helper'

RSpec.describe 'public_recipes/index.html.erb', type: :view do
  let(:recipes) { create_list(:recipe, 3, public: true) } # Assuming you have a factory for recipes

  before do
    assign(:recipes, recipes) # This sets up the instance variable for the view
    render
  end

  it 'displays the title "Public Recipes"' do
    expect(rendered).to have_selector('h1', text: 'Public Recipes')
  end

  it 'displays each public recipe name' do
    recipes.each do |recipe|
      expect(rendered).to have_content(recipe.name)
    end
  end

  it 'displays the author for each recipe' do
    recipes.each do |recipe|
      expect(rendered).to have_content("By: #{recipe.user.name}") # Assuming recipe belongs_to user
    end
  end

  context 'when there are no public recipes' do
    let(:recipes) { [] }

    it 'displays a message indicating there are no public recipes' do
      expect(rendered).to have_content('No public recipes yet')
    end
  end
end
