class ChangeAmountToDecimal < ActiveRecord::Migration[6.1]
  def change
    change_column :shopping_lists, :amount, "numeric USING CAST(amount AS numeric)"
    change_column :shopping_lists, :amount, :decimal, precision: 9, scale: 2
  end
end
