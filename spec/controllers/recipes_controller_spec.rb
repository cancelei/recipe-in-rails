require 'rails_helper'

RSpec.describe RecipesController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:recipe) { FactoryBot.create(:recipe, user:) }
  let(:valid_recipe_params) { { name: 'Test Recipe', preparation_time: 10, cooking_time: 20, description: 'Test description', public: true } }
  let(:invalid_recipe_params) { { name: '', preparation_time: 10, cooking_time: 20, description: 'Test description', public: true } }

  before do
    sign_in user
  end

  describe 'GET #index' do
    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end

    it 'lists all recipes associated with the current user' do
      FactoryBot.create_list(:recipe, 5, user:)
      get :index
      expect(assigns(:recipes).length).to eq(5)
    end
  end

  describe 'GET #show' do
    it 'renders the show template' do
      get :show, params: { id: recipe.id }
      expect(response).to render_template(:show)
    end

    it 'assigns the correct recipe' do
      get :show, params: { id: recipe.id }
      expect(assigns(:recipe)).to eq(recipe)
    end

    it 'initializes a new recipe-food object' do
      get :show, params: { id: recipe.id }
      expect(assigns(:recipe_food)).to be_a_new(RecipeFood)
    end
  end

  describe 'GET #new' do
    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end

    it 'initializes a new recipe object' do
      get :new
      expect(assigns(:recipe)).to be_a_new(Recipe)
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new recipe' do
        expect do
          post :create, params: { recipe: valid_recipe_params }
        end.to change(Recipe, :count).by(1)
      end

      it 'redirects to the new recipe with a notice' do
        post :create, params: { recipe: valid_recipe_params }
        expect(response).to redirect_to(Recipe.last)
        expect(flash[:notice]).to eq('Recipe created successfully!')
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new recipe' do
        expect do
          post :create, params: { recipe: invalid_recipe_params }
        end.not_to change(Recipe, :count)
      end

      it 'renders the new template with a notice' do
        post :create, params: { recipe: invalid_recipe_params }
        expect(response).to render_template(:new)
        expect(flash[:notice]).to eq('There was an error creating your recipe')
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid parameters' do
      it 'updates the recipe' do
        patch :update, params: { id: recipe.id, recipe: { name: 'Updated Recipe' } }
        recipe.reload
        expect(recipe.name).to eq('Updated Recipe')
      end

      it 'redirects to the recipe with a notice' do
        patch :update, params: { id: recipe.id, recipe: { name: 'Updated Recipe' } }
        expect(response).to redirect_to(recipe)
        expect(flash[:notice]).to eq('Recipe updated successfully!')
      end
    end

    context 'with invalid parameters' do
      it 'does not update the recipe' do
        patch :update, params: { id: recipe.id, recipe: { name: '' } }
        recipe.reload
        expect(recipe.name).not_to eq('')
      end

      it 'renders the edit template' do
        patch :update, params: { id: recipe.id, recipe: { name: '' } }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the recipe' do
      recipe_to_delete = FactoryBot.create(:recipe, user:)
      expect do
        delete :destroy, params: { id: recipe_to_delete.id }
      end.to change(Recipe, :count).by(-1)
    end

    it 'redirects to the recipes index with a notice' do
      delete :destroy, params: { id: recipe.id }
      expect(response).to redirect_to(recipes_path)
      expect(flash[:notice]).to eq('Recipe deleted successfully!')
    end
  end

  describe 'handling ActiveRecord::RecordNotFound' do
    it 'redirects to the recipes index with an alert' do
      get :show, params: { id: 'invalid' }
      expect(response).to redirect_to(recipes_path)
      expect(flash[:alert]).to eq('Recipe not found')
    end
  end
end
