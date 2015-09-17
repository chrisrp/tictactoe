#
# class game
class Game
  attr_reader :player1,
              :player2,
              :current_player

  PLAYER_MARKS = {
    player1: 'X',
    player2: 'O'
  }

  def initialize(name_player1, name_player2)
    @current_player = :player1
    @player1 = { player1: { mark: PLAYER_MARKS[:player1], name: name_player1 } }
    @player2 = { player2: { mark: PLAYER_MARKS[:player2], name: name_player2 } }

    @game_array = [[nil, nil, nil],
                   [nil, nil, nil],
                   [nil, nil, nil]]
  end

  def pick(current_player, x, y)
    fail InvalidPickException.new('Invalid pick') unless valid_pick?(x, y) &&
                                          valid_player?(current_player)

    @game_array[x][y] = PLAYER_MARKS[current_player.to_sym]

    @current_player = if @current_player == :player1
                        :player2
                      else
                        :player1
                      end
  end

  def current_state
    mark = winner_mark
    if mark
      { winner: PLAYER_MARKS.key(mark) }
    else
      { current_state: @game_array,
        current_player: @current_player }
    end
  end

  private

  def valid_player?(current_player)
    @current_player == current_player.to_sym
  end

  def valid_pick?(x, y)
    @game_array[x][y] == nil
  end

  def winner_mark
    winner_mark = check_columns ||
                  check_rows ||
                  check_left_diagonal ||
                  check_right_diagonal

    winner_mark
  end

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


  def check_right_diagonal
    if @game_array[0][2] == @game_array[1][1] &&
       @game_array[0][2] == @game_array[2][0] &&
       !@game_array[0][2].nil?

      @game_array[0][2]
    end
  end

  def check_left_diagonal
    if @game_array[0][0] == @game_array[1][1] &&
       @game_array[0][0] == @game_array[2][2] &&
       !@game_array[0][0].nil?

      @game_array[0][0]
    end
  end
end
