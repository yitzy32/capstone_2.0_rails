class Api::PantryItemsController < ApplicationController
  def create
    @ingredient = Ingredient.new(
      name: params[:name],
    )
    @ingredient.save

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

    render "show.json.jb"
  end
end
