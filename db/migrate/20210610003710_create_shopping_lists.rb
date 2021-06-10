class CreateShoppingLists < ActiveRecord::Migration[6.1]
  def change
    create_table :shopping_lists do |t|
      t.string :name
      t.decimal :unit, precision: 6, scale: 2
      t.string :amount

      t.timestamps
    end
  end
end
