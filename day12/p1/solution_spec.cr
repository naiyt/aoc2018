require "spec"
require "./solution"

describe "Day 12 Problem 1" do
  it "works with the sample input" do
    problem_input = <<-HERE
      initial state: #..#.#..##......###...###

      ...## => #
      ..#.. => #
      .#... => #
      .#.#. => #
      .#.## => #
      .##.. => #
      .#### => #
      #.#.# => #
      #.### => #
      ##.#. => #
      ##.## => #
      ###.. => #
      ###.# => #
      ####. => #
    HERE

    game_of_pots(problem_input).should eq(325)
  end

  it "generates the correct solution for my problem input" do
    game_of_pots(File.read("input.txt")).should eq(3472)
  end
end
