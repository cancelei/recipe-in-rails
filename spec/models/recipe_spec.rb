require 'rails_helper'

RSpec.describe Recipe, type: :model do
  let(:user) { FactoryBot.create(:user) }
  subject { FactoryBot.build(:recipe, user: user) }

  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:recipe_foods) }
    it { should have_many(:foods).through(:recipe_foods) }
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    context 'name validations' do
      it { should validate_presence_of(:name) }
      it { should validate_length_of(:name).is_at_most(255) }

      it 'validates uniqueness of name' do
        subject.save
        new_recipe = FactoryBot.build(:recipe, name: subject.name, user: subject.user)
        expect(new_recipe).not_to be_valid
      end
    end

    context 'time validations' do
      it { should validate_numericality_of(:preparation_time).only_integer.is_greater_than_or_equal_to(0) }
      it { should validate_numericality_of(:cooking_time).only_integer.is_greater_than_or_equal_to(0) }
    end

    context 'description and public validations' do
      it { should validate_presence_of(:description) }
      it { should validate_inclusion_of(:public).in_array([true, false]) }
    end

    it 'validates presence of user' do
      subject.user = nil
      expect(subject).not_to be_valid
      expect(subject.errors.messages[:user]).to include("must exist")
    end
  end
end
