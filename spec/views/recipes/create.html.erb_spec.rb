require 'rails_helper'

RSpec.describe 'recipes/create.html.erb', type: :view do
  let(:recipe) { build(:recipe) } # Assuming you have a factory for recipes

  before do
    assign(:recipe, recipe) # This sets up the instance variable for the view
    render
  end

  it 'displays a success message' do
    expect(rendered).to have_content('Recipe successfully created!')
  end

  it 'displays the name of the newly created recipe' do
    expect(rendered).to have_content(recipe.name)
  end

  # Add more tests based on the content of your create.html.erb

end
