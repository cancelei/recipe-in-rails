# spec/views/recipes/destroy.html.erb_spec.rb
require 'rails_helper'

RSpec.describe 'recipes/destroy.html.erb', type: :view do
  it 'displays a confirmation message' do
    # Render the view
    render

    # Add assertions for the content of the view
    expect(rendered).to have_content('Are you sure you want to delete this recipe?')
    # You can add more assertions as needed to test the view's content.
  end
end
