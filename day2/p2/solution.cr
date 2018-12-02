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
