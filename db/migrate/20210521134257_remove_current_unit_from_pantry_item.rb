class RemoveCurrentUnitFromPantryItem < ActiveRecord::Migration[6.1]
  def change
    remove_column :pantry_items, :current_unit, :string
  end
end
