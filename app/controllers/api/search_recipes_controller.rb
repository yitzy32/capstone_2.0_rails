class Api::SearchRecipesController < ApplicationController
  def index
    response = HTTP.get("https://api.spoonacular.com/recipes/complexSearch?query=#{params[:search]}&fillIngredients=true&instructionsRequired=true&addRecipeInformation=true&apiKey=#{Rails.application.credentials.spoonacular_api[:api_key]}").to_s
    @data = JSON.parse(response)
    @recipes = []
    @data["results"].each do |recipe|
      @recipe = {}
      @title = recipe["title"]
      @prep_time = recipe["readyInMinutes"]
      @image = recipe["image"]
      @servings = recipe["servings"]
      @source_name = recipe["sourceName"]
      @source_url = recipe["sourceUrl"]
      @summary = recipe["summary"]
      @recipe = { title: @title, prep_time: @prep_time, image: @image, servings: @servings, summary: @summary, source_name: @source_name, source_url: @source_url }
      @recipes << @recipe

      @ingredients = []
      recipe["extendedIngredients"].each do |extended_ingredient|
        @name = extended_ingredient["name"]
        @amount = extended_ingredient["amount"]
        @unit = extended_ingredient["unit"]
        @ingredients << { name: @name, amount: @amount, unit: @unit }
        @recipe[:ingredients] = @ingredients
      end
      @directions = []
      recipe["analyzedInstructions"][0]["steps"].each do |step|
        @number = step["number"]
        @instruction = step["step"]
        @directions << { number: @number, instruction: @instruction }
        @recipe[:directions] = @directions
      end
    end
    ap @recipes
    render "index.json.jb"
  end
end
