class ChangeUnitToString < ActiveRecord::Migration[6.1]
  def change
    change_column :shopping_lists, :unit, :string
  end
end
