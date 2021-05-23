class Api::SearchRecipesController < ApplicationController
  def index
    response = HTTP.get("https://api.spoonacular.com/recipes/complexSearch?query=#{params[:search]}&fillIngredients=true&instructionsRequired=true&addRecipeInformation=true&apiKey=#{Rails.application.credentials.spoonacular_api[:api_key]}").to_s
    @data = JSON.parse(response)
    @recipes = []
    @data["results"].each do |recipe|
      @recipe = {}
      @id = recipe["id"]
      @title = recipe["title"]
      @prep_time = recipe["readyInMinutes"]
      @image = recipe["image"]
      @servings = recipe["servings"]
      @source_name = recipe["sourceName"]
      @source_url = recipe["sourceUrl"]
      @summary = recipe["summary"]
      @recipe = { id: @id, title: @title, prep_time: @prep_time, image: @image, servings: @servings, summary: @summary, source_name: @source_name, source_url: @source_url }
      @recipes << @recipe

      @ingredients = []
      @data["extendedIngredients"].each do |extended_ingredient|
        @name = extended_ingredient["name"]
        @amount = extended_ingredient["amount"]
        @unit = extended_ingredient["unit"]
        @ingredients << { name: @name, amount: @amount, unit: @unit }
        @recipe[:ingredients] = @ingredients
      end
      @directions = []
      @data["analyzedInstructions"][0]["steps"].each do |step|
        @number = step["number"]
        @instruction = step["step"]
        @directions << { number: @number, instruction: @instruction }
        @recipe[:directions] = @directions
      end
    end
    ap @recipes
    render "index.json.jb"
  end

  def show
    # gets basic recipe info + ingredients
    response = HTTP.get("https://api.spoonacular.com/recipes/#{params[:id]}/information?apiKey=#{Rails.application.credentials.spoonacular_api[:api_key]}").to_s
    @data = JSON.parse(response)
    @recipe = {}
    @id = @data["id"]
    @title = @data["title"]
    @prep_time = @data["readyInMinutes"]
    @image = @data["image"]
    @servings = @data["servings"]
    @source_name = @data["sourceName"]
    @source_url = @data["sourceUrl"]
    @summary = @data["summary"]
    @recipe = { id: @id, title: @title, prep_time: @prep_time, image: @image, servings: @servings, summary: @summary, source_name: @source_name, source_url: @source_url }

    @ingredients = []
    @data["extendedIngredients"].each do |extended_ingredient|
      @name = extended_ingredient["name"]
      @amount = extended_ingredient["amount"]
      @unit = extended_ingredient["unit"]
      @ingredients << { name: @name, amount: @amount, unit: @unit }
      @recipe[:ingredients] = @ingredients
    end

    # gets directions
    response = HTTP.get("https://api.spoonacular.com/recipes/#{@recipe[:id]}/analyzedInstructions?apiKey=#{Rails.application.credentials.spoonacular_api[:api_key]}").to_s
    @data = JSON.parse(response)
    @directions = []
    @data[0]["steps"].each do |step|
      @number = step["number"]
      @instruction = step["step"]
      @directions << { number: @number, instruction: @instruction }
      @recipe[:directions] = @directions
    end
    render "show.json.jb"
  end

  def create
    response = HTTP.get("https://api.spoonacular.com/recipes/#{params[:id]}/information?includeNutrition=false&apiKey=#{Rails.application.credentials.spoonacular_api[:api_key]}")
    @data = JSON.parse(response)

    @recipe = Recipe.new(
      title: @data["title"],
      prep_time: @data["readyInMinutes"],
      servings: @data["servings"],
      source_name: @data["sourceName"],
      source_url: @data["sourceUrl"],
      image: @data["image"],
      summary: @data["summary"],
      user_id: current_user.id,
    )
    @recipe.save!

    @data["extendedIngredients"].each do |extended_ingredient|
      p extended_ingredient["name"]
      @ingredient = Ingredient.find_by(name: extended_ingredient["name"])
      if @ingredient == nil
        @ingredient = Ingredient.new(name: extended_ingredient["name"])
        @ingredient.save!
      end

      @ingredient_recipe = IngredientRecipe.new(
        ingredient_id: @ingredient.id,
        recipe_id: @recipe.id,
        unit: extended_ingredient["unit"],
        amount: extended_ingredient["amount"],
        user_id: current_user.id,
      )
      @ingredient_recipe.save!
    end

    response = HTTP.get("https://api.spoonacular.com/recipes/#{params[:id]}/analyzedInstructions?apiKey=#{Rails.application.credentials.spoonacular_api[:api_key]}").to_s
    @data = JSON.parse(response)

    @direction = Direction.new(
      number: @data[0]["steps"][0]["number"],
      instruction: @data[0]["steps"][0]["step"],
      recipe_id: @recipe.id,
    )
    @direction.save!

    render json: { message: "hello" }
  end
end
