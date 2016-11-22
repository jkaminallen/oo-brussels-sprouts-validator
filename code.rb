class Recipe
  attr_reader :name, :ingredients

  def initialize(name, ingredients, instructions)
    @name = name
    @ingredients = ingredients
    @instructions = instructions
  end

  def allergens
    safe = true
    @ingredients.each do |item|
      if item.safe_ingredient == false
        safe = false
      end
    end
    return safe
  end
end

class Ingredient
  SAFE_FOOD = ["Brussels sprouts", "spinach", "eggs", "milk", "tofu", "seitan", "bell peppers", "quinoa", "kale", "chocolate", "beer", "wine", "whiskey"]

  def initialize(quantity, unit, name)
    @quantity = quantity
    @unit = unit
    @name = name
  end

  def safe_ingredient
    SAFE_FOOD.include? @name
  end

  def self.parse(iso8601_string)
    tokens = iso8601_string.split(" ")
    quantity = tokens[0]
    unit = tokens[1]
    name = tokens [2..-1]

    Ingredient.new(quantity, unit, name)
  end
end

safe_name = "Chocolate Quinoa"
safe_ingredients = [
        Ingredient.new(1.0, "cup", "quinoa"),
        Ingredient.new(1.0, "cup", "chocolate")
      ]
safe_instructions = [
        "Melt chocolate.",
        "Pour over quinoa.",
        "Regret your life."
      ]
safe_recipe = Recipe.new(safe_name, safe_ingredients, safe_instructions)
puts "Is #{safe_recipe.name} safe? #{safe_recipe.allergens}"
