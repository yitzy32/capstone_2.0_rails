class CreatePantryItems < ActiveRecord::Migration[6.1]
  def change
    create_table :pantry_items do |t|
      t.string :name
      t.integer :ingredient_id
      t.string :starting_unit
      t.decimal :starting_amount, precision: 6, scale: 2
      t.string :current_unit
      t.decimal :current_amount, precision: 6, scale: 2
      t.integer :user_id

      t.timestamps
    end
  end
end
