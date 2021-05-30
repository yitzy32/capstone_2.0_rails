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
      @pantry_item_imperial_amount = @pantry_items[0][:current_amount]
      @pantry_item_name = @pantry_items[0][:name]
      @ingredient_imperial_unit = ingredient[:unit]
      @ingredient_imperial_amount = ingredient[:amount]

      # Checks if item in db is already at 0
      if @pantry_item_imperial_amount > 0
        # Checks if name has a space. If it does, replace those with dashes
        if @pantry_item_name.count(" ") > 0
          @pantry_item_name = @pantry_item_name.gsub(" ", "-")
        end

        # Converts the pantry_item into grams
        response = HTTP.get("https://api.spoonacular.com/recipes/convert?ingredientName=#{@pantry_item_name}&sourceAmount=#{@pantry_item_imperial_amount}&sourceUnit=#{@pantry_item_imperial_unit}&targetUnit=grams&apiKey=#{Rails.application.credentials.spoonacular_api[:api_key]}")
        @data = JSON.parse(response)

        @pantry_item_in_grams = @data["targetAmount"] # => Grabs gram amount from api

        # Convert ingredient used in recipe to grams
        response = HTTP.get("https://api.spoonacular.com/recipes/convert?ingredientName=#{@pantry_item_name}&sourceAmount=#{@ingredient_imperial_amount}&sourceUnit=#{@ingredient_imperial_unit}&targetUnit=grams&apiKey=#{Rails.application.credentials.spoonacular_api[:api_key]}")
        @data = JSON.parse(response)

        ingredient_in_grams = @data["targetAmount"] # => Grabs gram amount from api
        subtracted_pantry_item = @pantry_item_in_grams - ingredient_in_grams

        # Checks if newly subtracted item would be less than 0
        if subtracted_pantry_item > 0
          response = HTTP.get("https://api.spoonacular.com/recipes/convert?ingredientName=#{@pantry_item_name}&sourceAmount=#{subtracted_pantry_item}&sourceUnit=grams&targetUnit=#{@pantry_item_imperial_unit}&apiKey=#{Rails.application.credentials.spoonacular_api[:api_key]}")
          @data = JSON.parse(response)

          @pantry_items[0][:current_amount] = @data["targetAmount"]
          @pantry_items[0].save
        elsif subtracted_pantry_item < 0
          @pantry_items[0][:current_amount] = 0
          @pantry_items[0].save
        end
      elsif @pantry_item_imperial_amount < 0
        @pantry_items[0][:current_amount] = 0
        @pantry_items[0].save
      end
    end

    render "show.json.jb"
  end
end
