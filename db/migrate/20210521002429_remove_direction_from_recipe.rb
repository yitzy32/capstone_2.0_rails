class RemoveDirectionFromRecipe < ActiveRecord::Migration[6.1]
  def change
    remove_column :recipes, :directions, :string
  end
end
