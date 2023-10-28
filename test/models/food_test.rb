require 'test_helper'

RSpec.describe Food, type: :model do
  # Associations
  it { should belong_to(:user) }
  it { should have_many(:recipe_foods).dependent(:destroy) }

  # Validations
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:measurement_unit) }
  it { should validate_presence_of(:price) }
  it { should validate_numericality_of(:price).is_greater_than(0) }
  it { should validate_presence_of(:quantity) }
  it { should validate_numericality_of(:quantity).only_integer.is_greater_than_or_equal_to(0) }

  describe 'uniqueness of name scoped to user_id' do
    let(:user) { FactoryBot.create(:user) }
    let!(:food) { FactoryBot.create(:food, user:, name: 'apple') }

    it 'does not allow the same food name for the same user' do
      duplicate_food = FactoryBot.build(:food, user:, name: 'apple')
      expect(duplicate_food).not_to be_valid
      expect(duplicate_food.errors[:name]).to include('has already been taken')
    end

    it 'allows different food names for the same user' do
      different_food = FactoryBot.build(:food, user:, name: 'banana')
      expect(different_food).to be_valid
    end

    it 'allows the same food name for different users' do
      another_user = FactoryBot.create(:user)
      another_food = FactoryBot.build(:food, user: another_user, name: 'apple')
      expect(another_food).to be_valid
    end
  end
end
