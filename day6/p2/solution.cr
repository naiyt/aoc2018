def manhattan_distance(starting : Array(Int32), ending : Array(Int32))
  (starting[0] - ending[0]).abs + (starting[1] - ending[1]).abs
end

def chronal_coordinates(coordinates : Array(Array(Int32)), max_sum : Int32)
  max_x = coordinates.max_by { |coord| coord[0] }[0]
  max_y = coordinates.max_by { |coord| coord[1] }[1]
  area = 0

  (0..max_y+1).each do |y|
    (0..max_x+1).each do |x|
      area += 1 if coordinates.map { |coord| manhattan_distance([x,y], coord) }.sum < max_sum
    end
  end

  area
end
