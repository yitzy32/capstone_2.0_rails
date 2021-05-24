Rails.application.routes.draw do
  # EXAMPLE HTML ROUTE
  # get "/photos" => "photos#index"

  # EXAMPLE JSON ROUTE WITH API NAMESPACE
  namespace :api do
    post "/users" => "users#create"

    post "/sessions" => "sessions#create"

    get "/pantry_items" => "pantry_items#index"
    post "/pantry_items" => "pantry_items#create"

    get "/search_recipes" => "search_recipes#index"
    get "search_recipes/:id" => "search_recipes#show"
    post "search_recipes" => "search_recipes#create"
  end
end
