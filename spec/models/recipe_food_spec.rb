require 'rails_helper'

RSpec.describe RecipeFood, type: :model do
  describe 'associations' do
    it { should belong_to(:recipe) }
    it { should belong_to(:food) }
  end

  describe 'validations' do
    subject { FactoryBot.build(:recipe_food) }

    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without a recipe' do
      subject.recipe = nil
      expect(subject).not_to be_valid
      expect(subject.errors.messages[:recipe]).to include("must exist")
    end

    it 'is not valid without a food' do
      subject.food = nil
      expect(subject).not_to be_valid
      expect(subject.errors.messages[:food]).to include("must exist")
    end
  end
end
