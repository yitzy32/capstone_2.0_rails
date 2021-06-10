class Api::ShoppingListController < ApplicationController
  def index
    @shopping_list = ShoppingList.all
    render "index.json.jb"
  end
end
