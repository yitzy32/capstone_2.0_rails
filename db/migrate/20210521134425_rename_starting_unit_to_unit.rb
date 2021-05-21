class RenameStartingUnitToUnit < ActiveRecord::Migration[6.1]
  def change
    rename_column :pantry_items, :starting_unit, :unit
  end
end
