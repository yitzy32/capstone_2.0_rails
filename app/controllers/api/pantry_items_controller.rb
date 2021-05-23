class Api::PantryItemsController < ApplicationController
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

    render "show.json.jb"
  end
end
