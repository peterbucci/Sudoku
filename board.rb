require 'colorize'
require_relative "tile.rb"

class Board
  def self.from_file(puzzle)
    grid = Array.new
    puzzle.each { |line| grid << line.split("").map { |value| Tile.new(value) } }

    grid
  end

  def initialize(puzzle)
    @grid = Board.from_file(puzzle)
  end

  def render
    puts "\e[H\e[2J"
    puts "    " + @grid.map.with_index { |_, i| (i + 1) % 3 == 0 && i != 8 ? i.to_s + " |" : i.to_s }.join(" ")
    puts "    " + "-"*21
    
    @grid.each.with_index do |line, i| 
      create_line = i.to_s + " | "

      line.each.with_index do |tile, i2| 
        create_line += tile.value

        (i2 + 1) % 3 == 0 && i2 != 8 ? create_line += " | " : create_line += " "
      end

      puts create_line
      puts "    " + "-"*21 if (i + 1) % 3 == 0 && i != 8
    end
  end

  def solved?
    @grid.each do |line|
      row = ""
      line.each { |tile| row += tile.value }
      return false if (1..9).to_a.map(&:to_s).any? { |num| !row.include?(num) } 
    end

    return true
  end

  def [](pos)
    row = pos[0]
    column = pos[1]
    @grid[row][column]
  end

  def []=(pos, value)
    row = pos[0]
    column = pos[1]
    @grid[row][column].value = value
  end
end

