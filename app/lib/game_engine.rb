#
# main class that holds all the logic of the game
class GameEngine
  attr_reader :player1,
              :player2,
              :current_player

  PLAYER_MARKS = {
    player1: 'X',
    player2: 'O'
  }

  ##
  # Contstructor method
  #
  # ## Parameters
  #
  #   name_player1 [String] Name for player 1
  #   name_player2 [String] Name for player 2
  #
  def initialize(name_player1, name_player2)
    @current_player = :player1
    @player1 = { player1: { mark: PLAYER_MARKS[:player1], name: name_player1 } }
    @player2 = { player2: { mark: PLAYER_MARKS[:player2], name: name_player2 } }

    @game_array = [[nil, nil, nil],
                   [nil, nil, nil],
                   [nil, nil, nil]]
  end

  ##
  # Represents the pick of some user and chosen coordinates
  #
  # ## Parameters
  #
  #   player [String]  Player picking a coordinate
  #   x      [Integer] X coordinate
  #   y      [Integer] Y coordinate
  #
  # ## Exceptions
  #
  #  Throws InvalidPickException if player is not valid or if coordinate
  #  is out of boundaries
  #
  def pick(player, x, y)
    fail InvalidPickException.new('Invalid pick') unless valid_pick?(x, y) &&
                                          valid_player?(player)

    @game_array[x][y] = PLAYER_MARKS[player.to_sym]

    @current_player = if @current_player == :player1
                        :player2
                      else
                        :player1
                      end
  end

  ##
  # Returns a hash containing the current state of the game,
  # the current user able to do the next pick. If the last
  # pick resulted in a winner the player is returned.
  #
  def current_state
    result = { current_state: @game_array,
               current_player: @current_player }

    mark = winner_mark
    result.merge!(winner: PLAYER_MARKS.key(mark)) if mark

    result
  end

  private

  ##
  # Checks if the player is allowed to play
  #
  def valid_player?(player)
    @current_player == player.to_sym
  end

  ##
  # Checks if coordinate is valid
  #
  def valid_pick?(x, y)
    @game_array[x][y] == nil
  rescue Exception
    fail InvalidPickException.new
  end

  ##
  # Returns the mark of the winner if there' one.
  #
  def winner_mark
    check_columns ||
    check_rows ||
    check_left_diagonal ||
    check_right_diagonal
  end

  ##
  # Check if the values in the columns match and returns the mark
  #
  def check_columns
    for column in 0..2
      if @game_array[0][column] == @game_array[1][column] &&
         @game_array[0][column] == @game_array[2][column] &&
         !@game_array[0][column].nil?

        result = @game_array[0][column]
      end
    end

    result
  end

  ##
  # Check if the values in the rows match and returns the mark
  #
  def check_rows
    for row in 0..2
      if @game_array[row][0] == @game_array[row][1] &&
         @game_array[row][0] == @game_array[row][2] &&
         !@game_array[row][0].nil?

        result = @game_array[row][0]
      end
    end
    result
  end

  ##
  # Check if the values in the right diagonal match and returns the mark
  #
  def check_right_diagonal
    if @game_array[0][2] == @game_array[1][1] &&
       @game_array[0][2] == @game_array[2][0] &&
       !@game_array[0][2].nil?

      @game_array[0][2]
    end
  end

  ##
  # Check if the values in the right diagonal match and returns the mark
  #
  def check_left_diagonal
    if @game_array[0][0] == @game_array[1][1] &&
       @game_array[0][0] == @game_array[2][2] &&
       !@game_array[0][0].nil?

      @game_array[0][0]
    end
  end
end
