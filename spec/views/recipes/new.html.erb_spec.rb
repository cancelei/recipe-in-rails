# spec/views/recipes/new.html.erb_spec.rb
require 'rails_helper'

RSpec.describe 'recipes/new.html.erb', type: :view do
  it 'renders the new recipe form' do
    assign(:recipe, Recipe.new) # Assign a new recipe for the form

    # Render the view
    render

    # Add assertions for the form fields
    expect(rendered).to have_selector("form[action='/recipes'][method='post']") do
      expect(rendered).to have_field('recipe[name]')
      expect(rendered).to have_field('recipe[preparation_time]')
      expect(rendered).to have_field('recipe[cooking_time]')
      expect(rendered).to have_field('recipe[description]')
      expect(rendered).to have_field('recipe[public]', with: true)
      expect(rendered).to have_field('recipe[public]', with: false)
            expect(rendered).to have_button('Create Recipe')
    end
  end
end
