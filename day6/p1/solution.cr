def manhattan_distance(starting : Array(Int32), ending : Array(Int32))
  (starting[0] - ending[0]).abs + (starting[1] - ending[1]).abs
end

def edge_of_board(coordinates : Array(Int32), max_x, max_y)
  coordinates[0] <= 0 ||
    coordinates[1] <= 0 ||
    coordinates[0] >= max_x ||
    coordinates[1] >= max_y
end

def chronal_coordinates(coordinates : Array(Array(Int32)))
  max_x = coordinates.max_by { |coord| coord[0] }[0]
  max_y = coordinates.max_by { |coord| coord[1] }[1]
  matrix = [] of Array(Int32)
  (0..max_y+1).each { matrix.push(Array.new(max_x+1, -1)) }
  areas = {} of Int32 => Int32

  matrix.each_with_index do |row, y|
    row.each_with_index do |val, x|
      distances = {} of Int32 => Int32
      coordinates.each_with_index { |coordinate, i| distances[i] = manhattan_distance([x,y], coordinate) }
      coordinate_index, min_distance = distances.min_by { |_key, val| val }

      # Don't count tiles with an equal min distance to multiple points
      if distances.values.count(min_distance) == 1
        matrix[y][x] = coordinate_index
        areas[coordinate_index] ||= 0
        areas[coordinate_index] += 1 unless areas[coordinate_index] == -1
        # If we extend infinitely, give it a -1
        areas[coordinate_index] = -1 if edge_of_board([x,y], max_x, max_y)
      end
    end
  end

  areas.values.max
end
