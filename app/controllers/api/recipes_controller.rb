class Api::RecipesController < ApplicationController
  def index
    @recipes = Recipe.where(user_id: current_user.id)
    render "index.json.jb"
  end

  def show
    @recipe = Recipe.find_by(id: params[:id])
    render "show.json.jb"
  end

  def update
    @recipe = Recipe.find_by(id: params[:id])
    used_ingredient_ids = []
    @recipe.ingredients.each do |ingredient|
      @pantry_item = PantryItem.find_by(id: ingredient[:id])
      used_ingredient_ids << @pantry_item[:id]
    end

    i = used_ingredient_ids[0]
    while i <= used_ingredient_ids.length
      @pantry_item = PantryItem.find_by(ingredient_id: i)
      if @pantry_item[:unit] == "cup" || @pantry_item[:unit] == "cups" || @pantry_item[:unit] == "c"
        pantry_item_amount_in_ml = @pantry_item[:current_amount] * 237
      elsif @pantry_item[:unit] == "oz" || @pantry_item[:unit] == "ounce" || @pantry_item[:unit] == "ounces"
        pantry_item_amount_in_ml = @pantry_item[:current_amount] * 30
      elsif @pantry_item[:unit] == "tablespoon" || @pantry_item[:unit] == "tablespoons" || @pantry_item[:unit] == "tbs"
        pantry_item_amount_in_ml = @pantry_item[:current_amount] * 15
      elsif @pantry_item[:unit] == "teaspoon" || @pantry_item[:unit] == "teaspoons" || @pantry_item[:unit] == "tsp"
        pantry_item_amount_in_ml = @pantry_item[:current_amount] * 5
      end

      whole_used_ingredient = @recipe.ingredient_recipes.find_by(ingredient_id: i)

      if whole_used_ingredient[:unit] == "cup" || whole_used_ingredient[:unit] == "cups" || whole_used_ingredient[:unit] == "c"
        ingredient_amount_in_ml = whole_used_ingredient[:amount] * 237
      elsif whole_used_ingredient[:unit] == "oz" || whole_used_ingredient[:unit] == "ounce" || whole_used_ingredient[:unit] == "ounces"
        ingredient_amount_in_ml = whole_used_ingredient[:amount] * 30
      elsif whole_used_ingredient[:unit] == "tablespoon" || whole_used_ingredient[:unit] == "tablespoons" || whole_used_ingredient[:unit] == "tbs"
        ingredient_amount_in_ml = whole_used_ingredient[:amount] * 15
      elsif whole_used_ingredient[:unit] == "teaspoon" || whole_used_ingredient[:unit] == "teaspoons" || whole_used_ingredient[:unit] == "tsp"
        ingredient_amount_in_ml = whole_used_ingredient[:amount] * 5
      end

      new_pantry_item_amount_in_ml = pantry_item_amount_in_ml - ingredient_amount_in_ml

      if @pantry_item[:unit] == "cup" || @pantry_item[:unit] == "cups" || @pantry_item[:unit] == "c"
        @pantry_item[:current_amount] = new_pantry_item_amount_in_ml / 237
      elsif @pantry_item[:unit] == "oz" || @pantry_item[:unit] == "ounce" || @pantry_item[:unit] == "ounces"
        @pantry_item[:current_amount] = new_pantry_item_amount_in_ml / 30
      elsif @pantry_item[:unit] == "tablespoon" || @pantry_item[:unit] == "tablespoons" || @pantry_item[:unit] == "tbs"
        @pantry_item[:current_amount] = new_pantry_item_amount_in_ml / 15
      elsif @pantry_item[:unit] == "teaspoon" || @pantry_item[:unit] == "teaspoons" || @pantry_item[:unit] == "tsp"
        @pantry_item[:current_amount] = new_pantry_item_amount_in_ml / 5
      end

      @pantry_item.save

      i += 1
    end

    render json: { message: "Update successfull" }
  end
end
