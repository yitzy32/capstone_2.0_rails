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
    @recipe.ingredient_recipes.each do |ingredient|
      @pantry_items = PantryItem.where(ingredient_id: ingredient[:ingredient_id])
      @pantry_item_imperial_unit = @pantry_items[0][:unit]
      ap @pantry_item_imperial_unit
      @pantry_item_imperial_amount = @pantry_items[0][:current_amount]
      ap @pantry_item_imperial_amount
      @pantry_item_name = @pantry_items[0][:name]
      if @pantry_item_name.count(" ") > 0
        @pantry_item_name = @pantry_item_name.gsub(" ", "-")
      end

      response = HTTP.get("https://api.spoonacular.com/recipes/convert?ingredientName=#{@pantry_item_name}&sourceAmount=#{@pantry_item_imperial_amount}&sourceUnit=#{@pantry_item_imperial_unit}&targetUnit=grams&apiKey=#{Rails.application.credentials.spoonacular_api[:api_key]}")
      @data = JSON.parse(response)
      ap @data

      @ingredient_imperial_unit = ingredient[:unit]
      @ingredient_imperial_amount = ingredient[:amount]

      response = HTTP.get("https://api.spoonacular.com/recipes/convert?ingredientName=#{@pantry_item_name}&sourceAmount=#{@ingredient_imperial_amount}&sourceUnit=#{@ingredient_imperial_unit}&targetUnit=grams&apiKey=#{Rails.application.credentials.spoonacular_api[:api_key]}")
      @data = JSON.parse(response)
      ap @data
    end

    render json: { message: "Updated successfully" }
  end
end
