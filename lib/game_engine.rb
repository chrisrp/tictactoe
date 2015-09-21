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
  # Parameters
  #  String name_player1 - Name for player 1
  #  String name_player2 - Name for player 2
  #
  def initialize(name_player1, name_player2)
    @current_player = :player1
    @player1 = Player.new(name_player1, PLAYER_MARKS[:player1], 1)
    @player2 = Player.new(name_player2, PLAYER_MARKS[:player2], 2)

    @game_array = [[nil, nil, nil],
                   [nil, nil, nil],
                   [nil, nil, nil]]
  end

  ##
  # Represents the pick of some user and chosen coordinates
  #
  #  String  player - Player picking a coordinate
  #  Integer x      - X coordinate
  #  Integer y      - Y coordinate
  #
  # Exceptions
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

    if mark
      result.merge!(winner: player_by_mark(mark).name)
    end


    result
  end

  private

  ##
  # Gets player based on his mark
  #
  def player_by_mark(mark)
    player = if PLAYER_MARKS.key(mark) == :player1
                @player1
              else
                @player2
              end
    player
  end


  ##
  # Checks if the player passed is allowed to play
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
