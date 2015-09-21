# Class to represent the player
class Player
  attr_accessor :name, :mark, :order

  ##
  # Constructor
  #
  # Parameters
  #
  #   name  [String] Player's name
  #   mark  [String] Player's mark
  #   order [Integer] Player's order
  #
  def initialize(name, mark, order)
    @name = name
    @mark = mark
    @order = order
  end

  # converts this instance to hash
  def to_hash
    { "player#{@order}" => { mark: @mark, name: @name } }
  end

end
