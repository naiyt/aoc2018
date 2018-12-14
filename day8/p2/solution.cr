# 02 03 00 03 10 11 12 01 01 00 01 99 02 01 01 02
# AA -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
#       BB -- -- -- -- CC -- -- -- -- --
#                            DD -- --

def get_metadata(values : Array(Int32), start = 0)
  children = values[start]
  meta_data_count = values[start+1]
  length = 2 + meta_data_count
  value = 0
  next_start = start + 2

  children_values = (0...children).map do
    child_length, child_value = get_metadata(values, next_start)
    next_start += child_length
    length += child_length
    child_value.as(Int32)
  end

  if children == 0
    value = values[(start+length-meta_data_count...start+length)].sum
  else
    values[(start+length-meta_data_count...start+length)].each do |meta_data_index|
      next if meta_data_index - 1 >= children_values.size
      value += children_values[meta_data_index-1]
    end
  end

  { length, value }
end

def memory(input : Array(Int32))
  get_metadata(input)[1]
end
