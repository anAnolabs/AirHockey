import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';

// Import our organized components and models
import 'models/game_config.dart';
import 'models/score.dart';
import 'components/ball.dart';
import 'components/player_paddle.dart';
import 'components/bot_paddle.dart';
import 'components/goal.dart';
import 'components/scoreboard.dart';
import 'components/field_lines.dart';
import 'components/confetti.dart';
import 'screens/game_over_overlay.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: GameWidget(
        game: AirHockeyGame(),
        overlayBuilderMap: {
          'GameOver': (context, AirHockeyGame game) => GameOverOverlay(
            playerWon: game.playerWon,
            onRestart: game.restartGame,
          ),
        },
      ),
    ),
  ));
}

/// Main game class with organized OOP structure
class AirHockeyGame extends FlameGame with DragCallbacks {
  // Game components
  late PlayerPaddle _player;
  late BotPaddle _bot;
  late Ball _ball;
  late Goal _playerGoal;
  late Goal _opponentGoal;
  late ScoreBoard _scoreBoard;
  late FieldLines _fieldLines;
  
  // Game state
  final Score _score = Score();
  bool _gameOver = false;
  
  // Getters for external access
  bool get gameOver => _gameOver;
  bool get playerWon => _score.playerWon;
  
  @override
  Future<void> onLoad() async {
    // Initialize player paddle
    _player = PlayerPaddle(Vector2(
      size.x / 2 - GameConfig.paddleWidth / 2, 
      size.y - GameConfig.playerYOffset,
    ));
    
    // Initialize bot paddle
    _bot = BotPaddle(Vector2(
      size.x / 2 - GameConfig.paddleWidth / 2, 
      GameConfig.botYOffset,
    ));
    
    // Initialize ball with goal scoring callback
    _ball = Ball();
    _ball.onGoalHit = _handleGoalScored;
    
    // Initialize goals
    _playerGoal = Goal(isPlayerGoal: true);
    _opponentGoal = Goal(isPlayerGoal: false);
    
    // Initialize UI components
    _fieldLines = FieldLines();
    _scoreBoard = ScoreBoard();
    
    // Add all components to the game
    addAll([
      _fieldLines,
      _player, 
      _bot, 
      _ball, 
      _playerGoal, 
      _opponentGoal, 
      _scoreBoard,
    ]);
  }
  
  @override
  void onDragUpdate(DragUpdateEvent event) {
    if (!_gameOver) {
      _player.moveTo(event.localStartPosition.x, size.x);
    }
  }
  
  void _handleGoalScored(bool playerScored) {
    if (_gameOver) return;
    
    // Update score
    final gameEnded = playerScored 
        ? _score.increasePlayerScore()
        : _score.increaseOpponentScore();
    
    // Update score display
    _scoreBoard.updateScore(_score);
    
    if (gameEnded) {
      _endGame();
    } else {
      _showConfetti(playerScored);
      _ball.reset();
    }
  }
  
  void _endGame() {
    _gameOver = true;
    overlays.add('GameOver');
    _ball.removeFromParent();
    _bot.active = false;
  }
  
  void _showConfetti(bool playerScored) {
    add(Confetti(isWin: playerScored));
  }
  
  /// Restart the game to initial state
  void restartGame() {
    _score.reset();
    _gameOver = false;
    _bot.reset();
    
    // Re-add ball if removed
    if (!children.contains(_ball)) {
      _ball = Ball();
      _ball.onGoalHit = _handleGoalScored;
      add(_ball);
    } else {
      _ball.reset();
    }
    
    _scoreBoard.updateScore(_score);
    overlays.remove('GameOver');
  }
}