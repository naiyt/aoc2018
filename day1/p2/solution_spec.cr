require "spec"
require "./solution"

describe "Day 1 Problem 2" do
  it "works for test input 1" do
    first_repeated_frequency([1, -2, 3, 1]).should eq(2)
  end

  it "works for test input 2" do
    first_repeated_frequency([1, -1]).should eq(0)
  end

  it "works for test input 3" do
    first_repeated_frequency([3, 3, 4, -2, -4]).should eq(10)
  end

  it "works for test input 4" do
    first_repeated_frequency([-6, 3, 8, 5, -6]).should eq(5)
  end

  it "works for test input 5" do
    first_repeated_frequency([7, 7, -2, -7, -4]).should eq(14)
  end

  it "returns nil if a number could never repeat" do
    # No repeats possible if all negatives
    first_repeated_frequency([-7, -7, -1, -3]).should eq(nil)
    # No repeates possible if all positives
    first_repeated_frequency([7, 7, 1, 3]).should eq(nil)
  end

  it "raises an exception if we go over max_iterations" do
    expect_raises(MaxIterations) do
      first_repeated_frequency([1, 2, 3, 201, -10])
    end
  end
end

# Run using my test input
input = File.read("input.txt")
input_array = input.split("\n").map { |i| i.to_i }
solution = first_repeated_frequency(input_array)
puts "\n\nSolution is: #{solution}\n\n"
