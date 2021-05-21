class CreateIngredientRecipes < ActiveRecord::Migration[6.1]
  def change
    create_table :ingredient_recipes do |t|
      t.integer :ingredient_id
      t.integer :recipe_id
      t.string :unit
      t.decimal :amount, precision: 6, scale: 2
      t.integer :user_id

      t.timestamps
    end
  end
end
