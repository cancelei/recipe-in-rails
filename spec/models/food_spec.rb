require 'rails_helper'

RSpec.describe Food, type: :model do
  # Associations
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:recipe_foods).dependent(:destroy) }
  end

  # Validations
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:measurement_unit) }
    it { is_expected.to validate_presence_of(:price) }
    it { is_expected.to validate_numericality_of(:price).is_greater_than(0) }
    it { is_expected.to validate_presence_of(:quantity) }
    it { is_expected.to validate_numericality_of(:quantity).only_integer.is_greater_than_or_equal_to(0) }
  end

  # Uniqueness validation for name scoped to user_id
  describe 'uniqueness of name scoped to user_id' do
    let(:user) { create(:user) }
    let!(:food) { create(:food, user:, name: 'apple') }

    it 'does not allow the same food name for the same user' do
      food_with_same_name = build(:food, user:, name: 'apple')

      # Diagnostic steps:
      puts 'Validation errors:'
      food_with_same_name.valid?
      puts food_with_same_name.errors.full_messages
      puts "Initial food user_id: #{food.user_id}"
      puts "Initial food name: #{food.name}"
      puts "Food count with name 'apple' for user: #{Food.where(user:, name: 'apple').count}"

      expect(food_with_same_name).not_to be_valid
    end

    it 'allows different food names for the same user' do
      different_food = build(:food, user:, name: 'Banana')
      expect(different_food).to be_valid
    end

    it 'allows the same food name for different users' do
      different_user = create(:user)
      food_for_different_user = build(:food, user: different_user, name: 'apple')
      expect(food_for_different_user).to be_valid
    end
  end
end
