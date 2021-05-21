class CreateDirections < ActiveRecord::Migration[6.1]
  def change
    create_table :directions do |t|
      t.integer :number
      t.string :instruction
      t.integer :recipe_id

      t.timestamps
    end
  end
end
