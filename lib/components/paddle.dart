import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import '../models/game_config.dart';

/// Abstract base class for game paddles
abstract class Paddle extends PositionComponent {
  final Color color;
  
  Paddle({
    required Vector2 position,
    required this.color,
  }) : super(
    size: Vector2(GameConfig.paddleWidth, GameConfig.paddleHeight),
    position: position,
  );
  
  @override
  void render(Canvas canvas) {
    final paint = Paint()..color = color;
    canvas.drawRect(size.toRect(), paint);
  }
  
  /// Abstract method for paddle-specific update logic
  void updatePaddle(double dt);
  
  @override
  void update(double dt) {
    updatePaddle(dt);
  }
}