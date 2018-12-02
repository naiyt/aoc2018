require "benchmark"
require "./solution"

# Run with crystal run benchmark.cr --release -- 1 <number of iterations>

ids = File.read("biginput.txt").split("\n")
n = ARGV[0].to_i
puts "Benchmarking #{n} times..."

Benchmark.bm do |bm|
  bm.report("Fast") do
    n.times { common_letters(ids) }
  end

  bm.report("Bruteforce") do
    n.times { common_letters_bruteforce(ids) }
  end
end
