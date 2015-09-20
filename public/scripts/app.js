(function(){
  var app = angular.module('tictactoeGame', []);

  var player1 = { name: '', mark: '' };
  var player2 = { name: '', mark: '' };
  var currentPlayer;

  app.controller('GameController', function($scope, $http) {

    // controller attributes
    this.winner = '';
    this.p1 = player1;
    this.p2 = player2;
    this.currentPlayer = currentPlayer;

    gameController = this;

    this.start = function(){
      var req = {
        method: 'POST',
        url: '/game/create',
        data: { "player1": player1.name, "player2": player2.name }
      };

      $http(req).then(function(response){
        gameController.currentPlayer = response.data.current_player;
        gameController.p1 = response.data.player1;
        gameController.p2 = response.data.player2;
      });
    };

    this.pick = function(x, y){
      var req = {
        method: 'POST',
        url: '/game/pick',
        data: { 
          "current_player": gameController.currentPlayer,
          "x": x,
          "y": y }
      };

      $http(req).then(function(response){
        if (response.data.winner)
          gameController.winner = response.data.winner;
        else {
          gameController.currentPlayer = response.data.current_player;
          gameController.state = response.data.current_state;
        }
      });
    };

  });

})();
