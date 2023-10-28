require 'rails_helper'

RSpec.describe RecipesController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:recipe) { FactoryBot.create(:recipe, user: user) }

  before do
    sign_in user
  end

  describe 'GET #index' do
    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end

    it 'lists all recipes associated with the current user' do
      FactoryBot.create_list(:recipe, 5, user: user)
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
end
