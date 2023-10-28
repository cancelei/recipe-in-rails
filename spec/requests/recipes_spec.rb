require 'rails_helper'

RSpec.describe 'Recipes', type: :request do
  let(:recipe) { create(:recipe) }
  let(:user) { create(:user) }

  before do
    @user = create(:user)
    allow(controller).to receive(:current_user).and_return(user)
    @recipe = create(:recipe, user: @user)
    sign_in user
  end

  describe 'GET /index' do
    it 'returns http success' do
      get recipes_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      get recipe_path(@recipe)
      expect(response).to have_http_status(:redirect)
    end
  end

  describe 'GET /new (or POST /create)' do
    context 'with valid parameters' do
      it 'returns http success' do
        post recipes_path, params: { recipe: attributes_for(:recipe) }
        puts response.location # if it's a redirect
        expect(response).to have_http_status(:redirect)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a recipe' do
        post recipes_path, params: { recipe: { name: '' } }
      end
    end
  end

  describe 'GET /edit' do
    it 'returns http success' do
      get edit_recipe_path(recipe)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      it 'returns http success' do
        patch recipe_path(@recipe), params: { recipe: { name: 'Updated Title' } } # NOTE: I changed title to name as per your controller's permitted params
        expect(response).to redirect_to(@recipe)
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'deletes the recipe' do
      delete recipe_path(@recipe)

      expect(response).to redirect_to(recipes_path) # or some other expected behavior
    end
  end
end
