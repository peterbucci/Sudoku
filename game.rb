require_relative "board.rb"
require_relative "tile.rb"

class Game
  def initialize(puzzle)
    @board = Board.new(puzzle)

    play
  end

  def play
    return game_over if @board.solved?

    @board.render

    puts "\n" + "Enter a pos to change it's value. (e.g. 1,2)"
    pos = valid_position?(gets.chomp)

    puts "\n" + "Enter a number between 1 and 9 to change the value at this position."
    value = valid_value?(gets.chomp)

    @board[pos] = value

    play
  end

  def valid_position?(user_input)
    if /^[0-8],[0-8]$/.match?(user_input)
      pos = user_input.split(",").map(&:to_i)
      return pos if !@board[pos].fixed
    end

    puts "\n" + "Enter a *valid* pos to change it's value. (e.g. 1,2)"
    valid_position?(gets.chomp)
  end

  def valid_value?(user_input)
    return user_input if /^[1-9]$/.match?(user_input)

    puts "\n" + "Please enter an integer between 1 and 9."
    valid_value?(gets.chomp)
  end

  def game_over
    @board.render
    puts "\n" + "You win!"
  end
end

txt_file = File.readlines('.\puzzles\sudoku1_almost.txt').map(&:chomp)
Game.new(txt_file)