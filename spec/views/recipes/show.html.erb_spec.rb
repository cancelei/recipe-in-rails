require 'rails_helper'

RSpec.describe 'recipes/show.html.erb', type: :view do
  before do
    # You can set up any necessary variables or mocks here
    @recipe = FactoryBot.create(:recipe, name: 'Delicious Recipe', description: 'This is a test recipe.')
  end

  it 'displays the recipe details' do
    render

    # Ensure that the rendered view contains the recipe details you expect.
    expect(rendered).to have_content('Delicious Recipe')
    expect(rendered).to have_content('This is a test recipe.')
    # Add more assertions for other recipe details as needed
  end
end
