require 'rails_helper'

RSpec.describe 'recipes/edit.html.erb', type: :view do
  before do
    # Assuming you have a Recipe factory and you're using FactoryBot
    @recipe = FactoryBot.create(:recipe)
    assign(:recipe, @recipe)

    allow(view).to receive(:current_user).and_return(FactoryBot.create(:user))
  end
end
