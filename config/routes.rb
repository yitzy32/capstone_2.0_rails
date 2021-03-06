Rails.application.routes.draw do
  # EXAMPLE HTML ROUTE
  # get "/photos" => "photos#index"

  # EXAMPLE JSON ROUTE WITH API NAMESPACE
  namespace :api do
    post "/users" => "users#create"

    post "/sessions" => "sessions#create"

    get "/pantry_items" => "pantry_items#index"
    post "/pantry_items" => "pantry_items#create"
    patch "/pantry_items" => "pantry_items#update" # udates from shopping list and deletes list
    delete "/pantry_items" => "pantry_items#destroy"

    get "/search_recipes" => "search_recipes#index"
    get "/search_recipes/:id" => "search_recipes#show"
    post "/search_recipes" => "search_recipes#create"

    get "/recipes" => "recipes#index"
    get "/recipes/:id" => "recipes#show"
    patch "/recipes/:id" => "recipes#update"

    get "/ingredients" => "ingredients#index"

    get "/shopping_list" => "shopping_list#index"
    post "/shopping_list" => "shopping_list#create"
    delete "/shopping_list/:id" => "shopping_list#delete"
  end
end
