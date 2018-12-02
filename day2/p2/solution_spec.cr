require "spec"
require "./solution"

describe "Day 2 Problem 2" do
  it "works for the sample input" do
    common_letters(["abcde" ,"fghij" ,"klmno" ,"pqrst" ,"fguij" ,"axcye" ,"wvxyz"]).should eq("fgij")
  end

  it "returns nil for problems with no solution" do
    common_letters(["abcde" ,"efghi"]).should eq(nil)
  end

  it "returns the correct solution for my problem input" do
    common_letters(File.read("input.txt").split("\n")).should eq("jiwamotgsfrudclzbyzkhlrvp")
  end
end

describe "Days 2 Problem 2 - Bruteforce" do
  it "works for the sample input" do
    common_letters_bruteforce(["abcde" ,"fghij" ,"klmno" ,"pqrst" ,"fguij" ,"axcye" ,"wvxyz"]).should eq("fgij")
  end

  it "returns nil for problems with no solution" do
    common_letters_bruteforce(["abcde" ,"efghi"]).should eq(nil)
  end

  it "returns the correct solution for my problem input" do
    common_letters_bruteforce(File.read("input.txt").split("\n")).should eq("jiwamotgsfrudclzbyzkhlrvp")
  end
end
