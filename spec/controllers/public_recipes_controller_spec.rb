require 'rails_helper'

RSpec.describe PublicRecipesController, type: :controller do
  describe 'GET #index' do
    let!(:public_recipe1) { FactoryBot.create(:recipe, public: true, created_at: 1.day.ago) }
    let!(:public_recipe2) { FactoryBot.create(:recipe, public: true, created_at: 2.days.ago) }
    let!(:private_recipe) { FactoryBot.create(:recipe, public: false) }

    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end

    it 'lists all public recipes' do
      get :index
      expect(assigns(:recipes)).to match_array([public_recipe1, public_recipe2])
    end

    it 'does not include private recipes' do
      get :index
      expect(assigns(:recipes)).not_to include(private_recipe)
    end

    it 'orders recipes by creation date in descending order' do
      get :index
      expect(assigns(:recipes)).to eq([public_recipe1, public_recipe2])
    end
  end
end
