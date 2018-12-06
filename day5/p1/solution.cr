def swapcase(char)
  char.downcase == char ? char.upcase : char.downcase
end

def resulting_polymer_length_fast(polymer)
  polymer_array = polymer.split("")
  pointer_1 = 0
  pointer_2 = 1

  while pointer_2 < polymer_array.size
    if pointer_2 < polymer_array.size && polymer_array[pointer_1] == swapcase(polymer_array[pointer_2])
      polymer_array.delete_at(pointer_1..pointer_2)
      if pointer_1 > 0
        pointer_1 -= 1
        pointer_2 -= 1
      end
    else
      pointer_2 += 1
      pointer_1 = pointer_2 - 1
    end
  end

  polymer_array.size
end

def resulting_polymer_length_bruteforce(polymer)
  polymer_array = polymer.split("")
  next_array = [] of String
  reactions_exist = true

  while reactions_exist && polymer_array.size > 0
    reactions_exist = false
    pointer_1 = 0
    pointer_2 = 1

    while pointer_1 < polymer_array.size
      if pointer_2 < polymer_array.size && polymer_array[pointer_1] == swapcase(polymer_array[pointer_2])
        reactions_exist = true
        pointer_1 += 2
        pointer_2 += 2
      else
        next_array.push(polymer_array[pointer_1])
        pointer_1 += 1
        pointer_2 += 1
      end
    end

    polymer_array = next_array
    next_array = [] of String
  end

  polymer_array.size
end
