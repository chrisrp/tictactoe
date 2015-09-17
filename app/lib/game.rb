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
    @game_array[x][y] = PLAYER_MARKS[current_player.to_sym]

    @current_player = if @current_player == :player1
                        :player2
                      else
                        :player1
                      end
    current_state
  end

  private

    def current_state
      { current_state: @game_array,
        current_player: @current_player
      }
    end
end
