User.create!([
  { name: "adam", email: "adam@example.com", password_digest: "$2a$12$dycKXFGFVEXPRzq9cUCPnOV2OxPecmszL8CIutQ4mJme0ycFAInlq" },
])

Recipe.create!([
  { title: "Rice Krispies Treats", prep_time: 30, servings: 12, source_name: "Kelloggs", source_url: "https://www.ricekrispies.com/en_US/recipes/the-original-treats-recipe.html", image: "https://images.kglobalservices.com/www.ricekrispies.com/en_us/recipe/kicrecipe-1605/recip_img-7547527_rktreatssharp_r.jpg", summary: "Sugary, crispy, gooey and YUM! I say these Rice Krispy Treats are great for adults, as well as (an ocassional) treat for kids - they're too yummy not to love!", user_id: 1 },
  { title: "3 Ingredient Sugar Cookies", prep_time: 25, servings: 12, source_name: "Desserts on a Dime", source_url: "https://dessertsonadime.com/3-ingredient-sugar-cookie-recipe/", image: "https://dessertsonadime.com/wp-content/uploads/2020/05/Sugar-Cookies-15.jpg.webp", summary: "3 ingredient sugar cookies are so easy to make that you can make this 3 ingredient sugar cookies recipe any day of the week. If you are looking for 3 ingredient sugar cookies with no egg , this is the recipe to try and so delicious! ", user_id: 1 },
])

Ingredient.create!([
  { name: "butter" },
  { name: "marshmallows" },
  { name: "rice krispies" },
  { name: "sugar" },
  { name: "all purpose flour" },
])

IngredientRecipe.create!([
  { ingredient_id: 1, recipe_id: 1, unit: "tablespoons", amount: "3.0", user_id: 1 },
  { ingredient_id: 2, recipe_id: 1, unit: "oz", amount: "10.0", user_id: 1 },
  { ingredient_id: 3, recipe_id: 1, unit: "cups", amount: "6.0", user_id: 1 },
  { ingredient_id: 1, recipe_id: 2, unit: "stick", amount: "1.0", user_id: 1 },
  { ingredient_id: 4, recipe_id: 2, unit: "cup", amount: "0.33", user_id: 1 },
  { ingredient_id: 5, recipe_id: 2, unit: "cup", amount: "1.0", user_id: 1 },
])

Direction.create!([
  { number: 1, instruction: " In large saucepan melt butter over low heat. Add marshmallows and stir until completely melted. Remove from heat.", recipe_id: 1 },
  { number: 2, instruction: "Add KELLOGG'S RICE KRISPIES cereal. Stir until well coated.", recipe_id: 1 },
  { number: 3, instruction: "Using buttered spatula or wax paper evenly press mixture into 13 x 9 x 2-inch pan coated with cooking spray. Cool. Cut into 2-inch squares. Best if served the same day.", recipe_id: 1 },
  { number: 1, instruction: "Preheat oven to 325°.", recipe_id: 2 },
  { number: 2, instruction: "Use an electric mixer to cream the sugar and butter, whipping the two until the butter is almost white and the mixture is light and fluffy, almost like a slightly gritty frosting, then stir in flour.", recipe_id: 2 },
  { number: 3, instruction: "Form the cookies into 1\" balls, placing them about 2 inches apart on a baking sheet. If using sprinkles, flatten cookies into a disc shape and top with sprinkles.", recipe_id: 2 },
  { number: 4, instruction: "Bake for 15 to 17 minutes, or until the edges of the cookies are lightly golden.", recipe_id: 2 },
])

PantryItem.create!([
  { name: "butter", ingredient_id: 1, unit: "oz", starting_amount: "16.0", current_amount: "16.0", user_id: 1, image: "https://spoonacular.com/cdn/ingredients_500x500/butter.jpg" },
  { name: "marshmallows", ingredient_id: 2, unit: "oz", starting_amount: "24.0", current_amount: "24.0", user_id: 1, image: "https://spoonacular.com/cdn/ingredients_500x500/marshmallows.jpg" },
  { name: "rice krispies", ingredient_id: 3, unit: "oz", starting_amount: "42.0", current_amount: "42.0", user_id: 1, image: "https://spoonacular.com/cdn/ingredients_500x500/rice-krispies.jpg" },
  { name: "sugar", ingredient_id: 4, unit: "oz", starting_amount: "64.0", current_amount: "64.0", user_id: 1, image: nil },
  { name: "all purpose flour", ingredient_id: 5, unit: "lb", starting_amount: "5.0", current_amount: "5.0", user_id: 1, image: nil },
])
