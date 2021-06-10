class Api::ShoppingListController < ApplicationController
  def index
    @shopping_list = ShoppingList.all
    render "index.json.jb"
  end

  def create
    @shopping_list = ShoppingList.new(
      name: params[:name],
      unit: params[:unit],
      amount: params[:amount],
    )

    @shopping_list.save
    @ingredient = Ingredient.find_by(name: @shopping_list.name)
    @shopping_list.ingredient_id = @ingredient.id
    @shopping_list.save

    render "show.json.jb"
  end

  def delete
    @shopping_list = ShoppingList.find_by(id: params[:id])
    @shopping_list.destroy
    render json: { message: "Item removed from List" }
  end
end
