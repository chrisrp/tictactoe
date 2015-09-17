game = nil

before do
  if request.request_method == 'POST'
    params.merge!(JSON.parse(request.body.read))
  end
end

error InvalidPickException do
  halt 422, { error: 'invalid pick' }.to_json
end

#
#
#    {
#      "player1": "foo",
#      "player2": "bar"
#    }
#
post '/game/create' do
  content_type :json

  game = Game.new(params[:player1], params[:player2])

  body = { current_player: game.current_player }.merge(game.player1)
                                                .merge(game.player2)

  response.status = 201
  response.body = body.to_json
end

#    {
#      "current_player": "player1",
#      "x": 0,
#      "y": 0
#    }
#
post '/game/pick' do
  content_type :json

  game.pick(params[:current_player],
            params[:x],
            params[:y])

  response.status = 200
  response.body = game.current_state.to_json
end
