class Api::RecipesController < ApplicationController
  def index
    @recipes = Recipe.where(user_id: current_user.id)
    render "index.json.jb"
  end
end
