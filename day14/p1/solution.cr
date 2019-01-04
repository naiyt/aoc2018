def recipes(n)
  recipe_list = [3, 7]
  position_1 = 0
  position_2 = 1

  until recipe_list.size - n >= 10
    sum_of_recipes = recipe_list[position_1] + recipe_list[position_2]
    recipe_list.concat(sum_of_recipes.to_s.split("").map { |i| i.to_i })
    position_1 = (position_1 + recipe_list[position_1] + 1) % recipe_list.size
    position_2 = (position_2 + recipe_list[position_2] + 1) % recipe_list.size
  end

  recipe_list[(n...n+10)].join
end
