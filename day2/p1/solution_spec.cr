require "spec"
require "./solution"

describe "Day 2 Problem 1" do
  it "works with the sample input" do
    sample_input = ["abcdef", "bababc", "abbcde", "abcccd", "aabcdd", "abcdee", "ababab"]
    checksum(sample_input).should eq(12)
  end

  it "works for an empty array" do
    checksum([] of String).should eq(0)
  end

  it "works for my test input" do
    checksum(File.read("input.txt").split("\n")).should eq(5904)
  end
end
