require 'rails_helper'

RSpec.describe FoodsController, type: :controller do
  # Assuming you have a User and Food factory set up with FactoryBot
  let(:user) { FactoryBot.create(:user) }
  let(:food) { FactoryBot.create(:food, user: user) }

  before do
    # Assuming a method to sign in the user for the test
    sign_in user
  end

  describe 'GET #index' do
    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end

    it 'lists all foods associated with the current user' do
      FactoryBot.create_list(:food, 5, user: user)
      get :index
      expect(assigns(:foods).length).to eq(5)
    end
  end

  describe 'GET #show' do
    it 'renders the show template' do
      get :show, params: { id: food.id }
      expect(response).to render_template(:show)
    end

    it 'assigns the correct food' do
      get :show, params: { id: food.id }
      expect(assigns(:food)).to eq(food)
    end
  end

  describe 'GET #new' do
    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end

    it 'initializes a new food object' do
      get :new
      expect(assigns(:food)).to be_a_new(Food)
    end
  end
end
