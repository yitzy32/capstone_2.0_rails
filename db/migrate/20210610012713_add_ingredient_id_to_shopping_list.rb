class AddIngredientIdToShoppingList < ActiveRecord::Migration[6.1]
  def change
    add_column :shopping_lists, :ingredient_id, :integer
  end
end
