require 'rails_helper'

RSpec.describe RecipeFoodsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:recipe) { FactoryBot.create(:recipe, user:) }
  let(:food) { FactoryBot.create(:food, user:) }
  let(:recipe_food) { FactoryBot.create(:recipe_food, recipe:, food:) }
  let(:valid_recipe_food_params) { { food_id: food.id, quantity: 100 } }
  let(:invalid_recipe_food_params) { { food_id: nil, quantity: 100 } }

  before do
    sign_in user
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new recipe-food association' do
        expect do
          post :create, params: { recipe_id: recipe.id, recipe_food: valid_recipe_food_params }
        end.to change(RecipeFood, :count).by(1)
      end

      it 'redirects to the recipe with a notice' do
        post :create, params: { recipe_id: recipe.id, recipe_food: valid_recipe_food_params }
        expect(response).to redirect_to(recipe)
        expect(flash[:notice]).to eq('Ingredient added successfully.')
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new recipe-food association' do
        expect do
          post :create, params: { recipe_id: recipe.id, recipe_food: invalid_recipe_food_params }
        end.not_to change(RecipeFood, :count)
      end

      it 'renders the recipe show template with an alert' do
        post :create, params: { recipe_id: recipe.id, recipe_food: invalid_recipe_food_params }
        expect(response).to render_template('recipes/show')
        expect(flash[:alert]).to eq('Failed to add ingredient.')
      end
    end
  end

  describe 'DELETE #destroy' do
    before { recipe_food } # Ensure a recipe_food association exists

    it 'deletes the recipe-food association' do
      expect do
        delete :destroy, params: { recipe_id: recipe.id, id: recipe_food.id }
      end.to change(RecipeFood, :count).by(-1)
    end

    it 'redirects to the recipe with a notice' do
      delete :destroy, params: { recipe_id: recipe.id, id: recipe_food.id }
      expect(response).to redirect_to(recipe)
      expect(flash[:notice]).to eq('Ingredient removed successfully.')
    end
  end
end
