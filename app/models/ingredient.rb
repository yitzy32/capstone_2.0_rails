class Ingredient < ApplicationRecord
  has_many :pantry_items
  has_many :ingredient_recipes
  has_many :recipes, through: :ingredient_recipes
end
