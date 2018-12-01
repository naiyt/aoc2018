require "./solution"

# Compile with crystal build benchmark.cr --release
# Pass in the number of iterations like this: ./benchmark 10
# 100 iterations is running in 3.17s on my 2015 2.7Ghz MBP, with
# the sample input of 1,033 numbers. Pretty fast!

input = File.read("input.txt")
input_array = input.split("\n").map { |i| i.to_i }
ARGV[0].to_i.times { first_repeated_frequency(input_array) }
