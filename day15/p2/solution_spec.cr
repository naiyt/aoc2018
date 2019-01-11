require "spec"
require "./solution"

describe "Day 15 Problem 2" do
  it "works with sample input 1" do
    input = <<-HERE
      #######
      #.G...#
      #...EG#
      #.#.#G#
      #..G#E#
      #.....#
      #######
    HERE

    Game.new(input).run.should eq({29, 172, 15})
  end

  it "works with sample input 2" do
    input = <<-HERE
      #######
      #E..EG#
      #.#G.E#
      #E.##E#
      #G..#.#
      #..E#.#
      #######
    HERE

    Game.new(input).run.should eq({33, 948, 4})
  end

  it "works with sample input 3" do
    input = <<-HERE
      #######
      #E.G#.#
      #.#G..#
      #G.#.G#  -->  #..#..#
      #G..#.#
      #...E.#
      #######
    HERE

    Game.new(input).run.should eq({37, 94, 15})
  end

  it "works with sample input 4" do
    input = <<-HERE
      #######
      #.E...#
      #.#..G#
      #.###.#
      #E#G#G#
      #...#G#
      #######
    HERE

    Game.new(input).run.should eq({39, 166, 12})
  end

  it "works with sample input 5" do
    input = <<-HERE
      #########
      #G......#
      #.E.#...#
      #..##..G#
      #...##..#
      #...#...#
      #.G...G.#
      #.....G.#
      #########
    HERE

    Game.new(input).run.should eq({30, 38, 34})
  end

  it "works with my problem input" do
    Game.new(File.read("input.txt")).run.should eq({65, 2820})
  end
end
