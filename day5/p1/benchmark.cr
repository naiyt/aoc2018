require "benchmark"
require "./solution"

# Run with crystal run benchmark.cr --release -- 1 <number of iterations>

problem = File.read("input.txt")
n = ARGV[0].to_i
puts "Benchmarking #{n} times..."

Benchmark.bm do |bm|
  bm.report("Fast") do
    n.times { resulting_polymer_length_fast(problem) }
  end

  bm.report("Bruteforce") do
    n.times { resulting_polymer_length_bruteforce(problem) }
  end
end
