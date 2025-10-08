import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import '../models/game_config.dart';
import '../models/score.dart';

/// ScoreBoard UI component for displaying current score
class ScoreBoard extends PositionComponent {
  final TextPaint _textPaint = TextPaint(
    style: const TextStyle(
      fontSize: GameConfig.scoreFontSize,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
  );
  
  Score _score = Score();
  
  ScoreBoard() : super(position: Vector2(20, 20));
  
  /// Update the displayed score
  void updateScore(Score newScore) {
    _score = newScore.copy();
  }
  
  @override
  void render(Canvas canvas) {
    _textPaint.render(canvas, _score.scoreDisplay, Vector2.zero());
  }
  
  /// Get current score (read-only)
  Score get currentScore => _score.copy();
}