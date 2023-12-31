class Food < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods, dependent: :destroy
  has_many :related_records, class_name: 'RecipeFood', dependent: :destroy

  validates :name, presence: true, uniqueness: { scope: :user_id }
  validates :measurement_unit, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
