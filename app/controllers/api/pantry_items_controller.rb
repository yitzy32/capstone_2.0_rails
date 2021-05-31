class Api::PantryItemsController < ApplicationController
  def index
    @pantry_items = PantryItem.where(user_id: current_user.id)
    render "index.json.jb"
  end

  def create
    @ingredient = Ingredient.find_by(name: params[:name])
    response = HTTP.get("https://api.spoonacular.com/food/ingredients/#{@ingredient[:spoonacular_id]}/information?apiKey=#{Rails.application.credentials.spoonacular_api[:api_key]}").to_s
    @data = JSON.parse(response)

    @pantry_item = PantryItem.new(
      name: @ingredient.name,
      ingredient_id: @ingredient.id,
      unit: params[:unit],
      starting_amount: params[:starting_amount],
      user_id: current_user.id,
    )
    @pantry_item.save
    @pantry_item.current_amount = @pantry_item.starting_amount
    @pantry_item.image = "https://spoonacular.com/cdn/ingredients_500x500/#{@data["image"]}"
    @pantry_item.save

    render "show.json.jb"
  end

  def destroy
    @pantry_item = PantryItem.find_by(id: params[:id])
    @pantry_item.destroy
    render json: { message: "Item Removed" }
  end
end
