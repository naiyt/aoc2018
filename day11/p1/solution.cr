def power_level(serial_number, x, y)
    rack_id = x + 1 + 10
    power_level = rack_id * (y + 1)
    power_level += serial_number
    power_level *= rack_id
    hundreds_place = (power_level % (100 * 10) - power_level % 100) / 100
    hundreds_place - 5
end

def chronal_charge(serial_number)
  fuel_cell_grid = [] of Array(Int32|Nil)
  300.times { fuel_cell_grid.push(Array(Int32|Nil).new(300, nil)) }
  location_values = {} of Tuple(Int32, Int32) => Int32

  fuel_cell_grid.each_with_index do |row, y|
    row.each_with_index do |cell, x|
      fuel_cell_grid[y][x] ||= power_level(serial_number, x, y)
      next unless y < 298 && x < 298
      location_values[{x+1, y+1}] = (0..2).sum do |y_plus|
        (0..2).sum do |x_plus|
          fuel_cell_grid[y + y_plus][x + x_plus] ||= power_level(serial_number, x + x_plus, y + y_plus)
          (fuel_cell_grid[y + y_plus][x + x_plus]).as(Int32)
        end
      end
    end
  end

  location_values.max_by { |_k, v| v }[0]
end
