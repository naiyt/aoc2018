require "../p1/solution"

def shortest_possible_polymer(polymer : String)
  uniq_elements = polymer.downcase.split("").uniq
  polymer_array = polymer.split("")

  uniq_elements.map do |element|
    polymer_str = polymer_array.reject { |c| c.downcase == element }.join
    resulting_polymer_length_fast(polymer_str)
  end.min
end
