game = nil

before do
  if request.request_method == 'POST'
    params.merge!(JSON.parse(request.body.read))
  end
end

##
# POST /game/create - Endpoint to create a game instance
#
# ## Parameters
#
#   player1 [String] Name for the player1
#   player2 [String] Name for the player2
#
# ## Example
#
#   {
#     "player1": "foo",
#     "player2": "bar"
#   }
#
# ## Response Code
#
#   200
#
# ## Response Body
#
#  {
#    current_player": "player1",
#    "player1": {"mark":"X","name":"foo"},
#    "player2": {"mark":"O","name":"bar"}
#  }
#
post '/game/create', provides: :json do
  game = GameEngine.new(params[:player1], params[:player2])

  body = { current_player: game.current_player }.merge(game.player1)
  .merge(game.player2)

  response.status = 201
  response.body = body.to_json
end


##
# POST /game/pick - Endpoint to register players picks
#
# ## Parameters
#
#   current_player [String]  Player picking position
#   x              [Integer] x position
#   y              [Integer] y position
#
# ## Json example
#
#  {
#    "current_player": "player1",
#    "x": 0,
#    "y": 0
#  }
#
# ## Response Code
#
#   200 OK
#   422 Unprocessable - Format is correct but coordinate or current_player are invalid
#
# ## Response Body
#
#   {
#     "current_player": "player1",
#     "current_state": [['X', nil, 'X'],
#                       [nil, 'O', nil],
#                       [nil, nil, nil]]
#   }
#
#   OR
#
#   { "winner": "player1" }
#
#   if theres a winner
#
post '/game/pick', provides: :json do
  game.pick(params[:current_player],
            params[:x],
            params[:y])

  response.body = game.current_state.to_json
end
