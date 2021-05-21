class CreateRecipes < ActiveRecord::Migration[6.1]
  def change
    create_table :recipes do |t|
      t.string :title
      t.integer :prep_time
      t.integer :servings
      t.string :source_name
      t.string :source_url
      t.string :image
      t.string :summary
      t.string :directions
      t.integer :user_id

      t.timestamps
    end
  end
end
