def recipe_count(n)
  recipe_list = [3, 7]
  position_1 = 0
  position_2 = 1
  n = n.split("").map { |i| i.to_i }

  loop do
    sum_of_recipes = recipe_list[position_1] + recipe_list[position_2]
    new_recipes = sum_of_recipes.to_s.split("").map { |i| i.to_i }

    new_recipes.each do |recipe|
      recipe_list.push(recipe)
      if recipe_list.size >= n.size && recipe_list[(recipe_list.size-n.size..-1)] == n
        return recipe_list.size - n.size
      end
    end

    position_1 = (position_1 + recipe_list[position_1] + 1) % recipe_list.size
    position_2 = (position_2 + recipe_list[position_2] + 1) % recipe_list.size
  end
end
