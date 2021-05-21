class Recipe < ApplicationRecord
  belongs_to :user
  has_many :directions
  has_many :ingredient_recipes
  has_many :ingredients, through: :ingredient_recipes
end
