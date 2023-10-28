class Recipe < ApplicationRecord
  belongs_to :user

has_many :recipe_foods, dependent: :destroy

  has_many :foods, through: :recipe_foods


  validates :name, presence: true, length: { maximum: 255 }, uniqueness: { scope: :user_id }
  validates :preparation_time, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :cooking_time, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :description, presence: true
  validates :public, inclusion: { in: [true, false] }
  validates :user_id, presence: true
end
