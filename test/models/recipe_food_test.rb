require 'test_helper'

RSpec.describe RecipeFood, type: :model do
  # Associations
  it { should belong_to(:recipe) }
  it { should belong_to(:food) }
end
