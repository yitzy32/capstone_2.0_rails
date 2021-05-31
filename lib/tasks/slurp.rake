namespace :slurp do
  desc "TODO"
  task ingredients: :environment do
    require "csv"

    csv_text = File.read(Rails.root.join("lib", "csvs", "top-1k-ingredients.csv"))
    csv = CSV.parse(csv_text, :headers => true, :encoding => "ISO-8859-1")
    csv.each do |row|
      i = Ingredient.new
      i.name = row["name"]
      i.spoonacular_id = row["spoonacular_id"]
      i.save
      puts row.to_hash
    end
    puts csv_text
  end
end
