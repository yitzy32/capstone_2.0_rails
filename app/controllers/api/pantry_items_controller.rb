class Api::PantryItemsController < ApplicationController
  def index
    @pantry_items = PantryItem.where(user_id: current_user.id)
    render "index.json.jb"
  end

  def create
    @ingredient = Ingredient.find_by(name: params[:name])
    if @ingredient == nil
      @ingredient = Ingredient.new(name: params[:name])
      @ingredient.save!
    end

    @pantry_item = PantryItem.new(
      name: @ingredient.name,
      ingredient_id: @ingredient.id,
      unit: params[:unit],
      starting_amount: params[:starting_amount],
      user_id: current_user.id,
    )
    @pantry_item.save
    @pantry_item.current_amount = @pantry_item.starting_amount
    @pantry_item.save

    if @ingredient[:name].count(" ") > 0
      @ingredient[:name] = @ingredient[:name].gsub(" ", "-")
      ap "successfully changed name:"
      ap @ingredient[:name]
    end

    response = HTTP.get("https://api.spoonacular.com/food/ingredients/search?query=#{@ingredient[:name]}&number=50&apiKey=#{Rails.application.credentials.spoonacular_api[:api_key]}").to_s
    @data = JSON.parse(response)

    if @ingredient[:name].count("-") > 0
      @ingredient[:name] = @ingredient[:name].gsub("-", " ")
      ap "CHANGED NAME BACK!!!"
      ap @ingredient[:name]
    end

    @data["results"].each do |result|
      if result["name"] == @ingredient[:name]
        @pantry_item.image = "https://spoonacular.com/cdn/ingredients_500x500/#{result["image"]}"
        @pantry_item.save
        ap @pantry_item.image
      end
    end
    render "show.json.jb"
  end

  def destroy
    @pantry_item = PantryItem.find_by(id: params[:id])
    @pantry_item.destroy
    render json: { message: "Item Removed" }
  end
end
