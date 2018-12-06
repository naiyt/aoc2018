require "spec"
require "./solution"

describe "Day 4 Problem 1" do
  it "works with the sample input" do
    resulting_polymer_length_fast("dabAcCaCBAcCcaDA").should eq(10)
  end

  it "generates the correct solution for my problem input" do
    resulting_polymer_length_fast(File.read("input.txt")).should eq(11042)
  end

  it "wat" do
    resulting_polymer_length_fast("abbaABBA").should eq(0)
  end
end
