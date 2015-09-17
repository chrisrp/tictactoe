class Game

  PLAYER_MARKS = {
    player1: 'X',
    player2: 'O'
  }

  def initialize
    @game_array = [ [nil, nil, nil],
                    [nil, nil, nil],
                    [nil, nil, nil] ]
  end

  def start(player1, player2)
    @current_player = :player1

    { current_player: @current_player,
      player1: { mark: PLAYER_MARKS[:player1], name: player1 },
      player2: { mark: PLAYER_MARKS[:player2], name: player2 }
    }
  end

  def pick(current_player, x, y)
    raise InvalidPickException.new unless valid_pick?(x, y) &&
                                          valid_player?(current_player)

    @game_array[x][y] = PLAYER_MARKS[current_player.to_sym]

    @current_player = if @current_player == :player1
                        :player2
                      else
                        :player1
                      end

    mark = any_winner?
    if mark
      { winner: PLAYER_MARKS.key(mark) }
    else
      current_state
    end
  end

  private

  def any_winner?
    mark = nil

    # find columns
    for column in 0..2
      if @game_array[0][column] == @game_array[1][column] &&
        @game_array[0][column] == @game_array[2][column] &&
        @game_array[0][column] != nil

        mark = @game_array[0][column]
      end
    end

    return mark if mark

    # find rows
    for row in 0..2
      if @game_array[row][0] == @game_array[row][1] &&
         @game_array[row][0] == @game_array[row][2] &&
         @game_array[row][0] != nil

        mark = @game_array[row][0]
      end
    end

    return mark if mark

    # diagonal left to right
    if @game_array[0][0] == @game_array[1][1] &&
       @game_array[0][0] == @game_array[2][2] &&
       @game_array[0][0] != nil

      mark = @game_array[0][0]
    end

    return mark if mark

    # diagonal right to left
    if @game_array[0][2] == @game_array[1][1] &&
       @game_array[0][2] == @game_array[2][0] &&
       @game_array[0][2] != nil

      mark = @game_array[0][2]
    end

    mark
  end

    def valid_player?(current_player)
      @current_player == current_player.to_sym
    end

    def valid_pick?(x, y)
      @game_array[x][y] == nil
    end

    def current_state
        { current_state: @game_array,
          current_player: @current_player
        }
    end
end
