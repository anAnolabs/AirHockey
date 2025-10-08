import '../models/game_config.dart';

/// Score management class with game state logic
class Score {
  int _playerScore = 0;
  int _opponentScore = 0;
  
  // Getters for accessing scores
  int get playerScore => _playerScore;
  int get opponentScore => _opponentScore;
  
  // Game state properties
  bool get isGameOver => _playerScore >= GameConfig.maxScore || _opponentScore >= GameConfig.maxScore;
  bool get playerWon => _playerScore > _opponentScore;
  String get scoreDisplay => "$_playerScore : $_opponentScore";
  
  /// Increase player score and return if game is over
  bool increasePlayerScore() {
    _playerScore++;
    return isGameOver;
  }
  
  /// Increase opponent score and return if game is over  
  bool increaseOpponentScore() {
    _opponentScore++;
    return isGameOver;
  }
  
  /// Reset scores to zero
  void reset() {
    _playerScore = 0;
    _opponentScore = 0;
  }
  
  /// Copy constructor for creating a copy of current score
  Score copy() {
    final newScore = Score();
    newScore._playerScore = _playerScore;
    newScore._opponentScore = _opponentScore;
    return newScore;
  }
  
  @override
  String toString() => scoreDisplay;
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Score && 
           other._playerScore == _playerScore && 
           other._opponentScore == _opponentScore;
  }
  
  @override
  int get hashCode => _playerScore.hashCode ^ _opponentScore.hashCode;
}