class AddApiIdToIngredients < ActiveRecord::Migration[6.1]
  def change
    add_column :ingredients, :spoonacular_id, :integer
  end
end
