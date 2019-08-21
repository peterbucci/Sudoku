class Tile
  attr_reader :fixed
  attr_accessor :value

  def initialize(value)
    @value = value
    @fixed = value.to_i > 0
  end

  def render
    puts " #{value} "
  end
end