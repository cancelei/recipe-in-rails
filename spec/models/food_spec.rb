require 'rails_helper'

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
    let(:user) { create(:user) }
    let!(:food) { create(:food, user: user, name: 'apple') }

    it 'does not allow the same food name for the same user' do
      food_with_same_name = build(:food, user: user, name: 'apple')
      expect(food_with_same_name).not_to be_valid
    end

    it 'allows different food names for the same user' do
      different_food = build(:food, user: user, name: "Banana")
      expect(different_food).to be_valid
    end

    it 'allows the same food name for different users' do
      different_user = create(:user)
      food_for_different_user = build(:food, user: different_user, name: "apple")
      expect(food_for_different_user).to be_valid
    end
  end
end
