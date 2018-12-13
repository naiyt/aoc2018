# 02 03 00 03 10 11 12 01 01 00 01 99 02 01 01 02
# AA -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
#       BB -- -- -- -- CC -- -- -- -- --
#                            DD -- --

def get_metadata(values : Array(Int32), start = 0, meta_data = [] of Int32)
  children = values[start]
  meta_data_count = values[start+1]
  length = 2 + meta_data_count

  next_start = start + 2
  children.times do
    child_length, meta_data = get_metadata(values, next_start, meta_data)
    next_start += child_length
    length += child_length
  end

  meta_data.concat(values[(start+length-meta_data_count...start+length)])
  {length, meta_data}
end

def memory(input : Array(Int32))
  get_metadata(input)[1].sum
end
