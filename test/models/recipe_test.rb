require 'test_helper'

RSpec.describe Recipe, type: :model do
  # Associations
  it { should belong_to(:user) }
  it { should have_many(:recipe_foods) }
  it { should have_many(:foods).through(:recipe_foods) }

  # Validations
  it { should validate_presence_of(:name) }
  it { should validate_length_of(:name).is_at_most(255) }
  it { should validate_numericality_of(:preparation_time).only_integer.is_greater_than_or_equal_to(0) }
  it { should validate_numericality_of(:cooking_time).only_integer.is_greater_than_or_equal_to(0) }
  it { should validate_presence_of(:description) }
  it { should validate_inclusion_of(:public).in_array([true, false]) }
  it { should validate_presence_of(:user_id) }

  # Additional tests can be added for any custom logic or methods you might have in the Recipe model.
end
