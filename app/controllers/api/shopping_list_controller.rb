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
    render "show.json.jb"
  end
end
