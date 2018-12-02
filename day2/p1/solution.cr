def checksum(ids : Array(String))
  twos = threes = 0

  ids.each do |id|
    frequency_hash = {} of String => Int32

    id.split("").each do |char|
      frequency_hash[char] ||= 0
      frequency_hash[char] += 1
    end

    twos += 1 if frequency_hash.any? { |_key, val| val == 2 }
    threes += 1 if frequency_hash.any? { |_key, val| val == 3 }
  end

  twos * threes
end
