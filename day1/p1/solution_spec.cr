require "spec"
require "./solution"

describe "Day 1 Problem 1" do
  it "works for test input 1" do
    frequency_detector([1, -2, 3, 1]).should eq(3)
  end

  it "works for test input 2" do
    frequency_detector([1, 1, 1]).should eq(3)
  end

  it "works for test input 3" do
    frequency_detector([1, 1, -2]).should eq(0)
  end

  it "works for test input 4" do
    frequency_detector([-1, -2, -3]).should eq(-6)
  end

  it "works for an empty array" do
    frequency_detector([] of Int32).should eq(0)
  end
end

# Run using my test input
input = File.read("input.txt")
input_array = input.split("\n").map { |i| i.to_i }
solution = frequency_detector(input_array)
puts "\n\nSolution is: #{solution}\n\n"
