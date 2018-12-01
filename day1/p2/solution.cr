class MaxIterations < Exception
end

def first_repeated_frequency(frequencies : Array(Int32))
  # No solution is possible if all frequencies are negative or positive
  return nil if frequencies.all? { |i| i < 0 } || frequencies.all? { |i| i > 0 }

  max_iterations = 1_000_000
  sum = current_iteration = 0
  cache = {} of Int32 => Bool
  while true
    frequencies.each do |num|
      current_iteration += 1
      raise MaxIterations.new("reached #{max_iterations} iterations") if current_iteration > max_iterations
      return sum if cache.has_key?(sum)
      cache[sum] = true
      sum += num
    end
  end
end
