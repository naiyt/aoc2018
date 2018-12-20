class ChronalCharge
  GRID_SIZE = 300

  getter serial_number : Int32

  def initialize(serial_number)
    @serial_number = serial_number
  end

  def solve
    sum = [] of Array(Int32)
    (GRID_SIZE+1).times { sum.push(Array.new(GRID_SIZE+1, 0)) }

    (1..300).each do |y|
      (1..300).each do |x|
        power = power_level(x, y)
        sum[y][x] = power + sum[y - 1][x] + sum[y][x - 1] - sum[y - 1][x - 1]
      end
    end

    best_x = best_y = best_size = best_val = 0
    (1..300).each do |s|
      (s..300).each do |y|
        (s..300).each do |x|
          total = sum[y][x] - sum[y - s][x] - sum[y][x - s] + sum[y - s][x - s]
          if total > best_val
            best_x = x - s + 2
            best_y = y - s + 2
            best_size = s
            best_val = total
          end
        end
      end
    end

    { best_x, best_y, best_size }
  end

  def power_level(x, y)
    rack_id = x + 1 + 10
    power_level = rack_id * (y + 1)
    power_level += serial_number
    power_level *= rack_id
    hundreds_place = (power_level % (100 * 10) - power_level % 100) / 100
    hundreds_place - 5
  end
end
