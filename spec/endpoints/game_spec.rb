require 'spec_helper'

RSpec.describe 'Game' do
  let(:response) { JSON.parse(last_response.body) }
  before do
    post '/game/create', { player1: 'foo', player2: 'bar' }.to_json
  end

  describe 'POST /game/create' do
    context 'when I create a game' do
      it { expect(last_response.status).to eq 201 }
      it { expect(response['current_player']).to eq 'player1' }

      it 'should return the marks' do
        expect(response['player1']['mark']).to eq('X')
        expect(response['player2']['mark']).to eq('O')
      end

      it 'should return player names' do
        expect(response['player1']['name']).to eq('foo')
        expect(response['player2']['name']).to eq('bar')
      end
    end
  end

  describe 'POST /game/pick' do
    context 'when player 1 makes a possible choice' do
      before do
        post '/game/pick', { current_player: 'player1', x: 0, y: 0 }.to_json
      end

      it 'should return the game state' do
        expect(last_response.status).to eq 200
        expect(response['current_state'][0][0]).to eq('X')
        expect(response['current_player']).to eq('player2')
      end
    end

    context 'when player 2 makes a possible choice' do
      before do
        post '/game/pick', { current_player: 'player1', x: 0, y: 0 }.to_json
        post '/game/pick', { current_player: 'player2', x: 0, y: 1 }.to_json
      end

      it 'should return the game state' do
        expect(last_response.status).to eq 200
        expect(response['current_state'][0][0]).to eq('X')
        expect(response['current_state'][0][1]).to eq('O')
        expect(response['current_player']).to eq('player1')
      end
    end

    context 'when player 2 makes a invalid choice' do
      before do
        post '/game/pick', { current_player: 'player1', x: 0, y: 0 }.to_json
        post '/game/pick', { current_player: 'player2', x: 0, y: 0 }.to_json
      end

      it { expect(last_response.status).to eq 422 }
    end

    context 'when player 1 tries to play twice' do
      before do
        post '/game/pick', { current_player: 'player1', x: 0, y: 0 }.to_json
        post '/game/pick', { current_player: 'player1', x: 0, y: 1 }.to_json
      end

      it { expect(last_response.status).to eq 422 }
    end

    context 'when player 1 wins in column 0' do
      before do
        post '/game/pick', { current_player: 'player1', x: 0, y: 0 }.to_json
        post '/game/pick', { current_player: 'player2', x: 0, y: 1 }.to_json
        post '/game/pick', { current_player: 'player1', x: 1, y: 0 }.to_json
        post '/game/pick', { current_player: 'player2', x: 0, y: 2 }.to_json
        post '/game/pick', { current_player: 'player1', x: 2, y: 0 }.to_json
      end

      it { expect(last_response.status).to eq 200 }
      it { expect(response['winner']).to eq('player1') }
    end

    context 'when player 1 wins in row 0' do
      before do
        post '/game/pick', { current_player: 'player1', x: 0, y: 0 }.to_json
        post '/game/pick', { current_player: 'player2', x: 1, y: 1 }.to_json
        post '/game/pick', { current_player: 'player1', x: 0, y: 1 }.to_json
        post '/game/pick', { current_player: 'player2', x: 2, y: 2 }.to_json
        post '/game/pick', { current_player: 'player1', x: 0, y: 2 }.to_json
      end

      it { expect(last_response.status).to eq 200 }
      it { expect(response['winner']).to eq('player1') }
    end

    context 'when player 2 wins in diagonal' do
      before do
        post '/game/pick', { current_player: 'player1', x: 0, y: 1 }.to_json
        post '/game/pick', { current_player: 'player2', x: 0, y: 0 }.to_json
        post '/game/pick', { current_player: 'player1', x: 0, y: 2 }.to_json
        post '/game/pick', { current_player: 'player2', x: 1, y: 1 }.to_json
        post '/game/pick', { current_player: 'player1', x: 1, y: 2 }.to_json
        post '/game/pick', { current_player: 'player2', x: 2, y: 2 }.to_json
      end

      it { expect(last_response.status).to eq 200 }
      it { expect(response['winner']).to eq('player2') }
    end
  end
end
