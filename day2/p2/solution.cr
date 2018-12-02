# O(n * k), where k is the length of the ids and n is the number of ids
def common_letters(ids : Array(String))
  set = Set(String).new

  ids.each do |id|
    (0...id.size).each do |i|
      key = [id[(0...i)], "_", id[(i+1..-1)]].join
      return [id[(0...i)], id[(i+1..-1)]].join if set.includes?(key)
      set.add(key)
    end
  end

  nil
end

# O(n^2 * k)
def common_letters_bruteforce(ids : Array(String))
  ids.each_with_index do |id, index|
    ids[index+1..-1].each do |other_id|
      similarity = (0...id.size).count { |i| id[i] == other_id[i] }
      if similarity == id.size - 1
        diff_index = (0...id.size).find { |i| id[i] != other_id[i] }.as(Int32)
        return [id[(0...diff_index)], id[(diff_index+1..-1)]].join
      end
    end
  end

  nil
end
