import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'paddle.dart';
import '../models/game_config.dart';

/// AI-controlled paddle
class BotPaddle extends Paddle with HasGameRef {
  bool _active = true;
  
  BotPaddle(Vector2 position) 
    : super(position: position, color: Colors.red);
  
  // Getters and setters
  bool get active => _active;
  set active(bool value) => _active = value;
  
  @override
  void updatePaddle(double dt) {
    if (!_active) return;
    
    // Find the ball component to track it
    final ball = gameRef.children.whereType<PositionComponent>()
        .firstWhere((component) => component.runtimeType.toString() == 'Ball');
    
    // Simple AI: follow the ball's x position
    if (ball.position.x > position.x + size.x / 2) {
      position.x = (position.x + GameConfig.botSpeed * dt)
          .clamp(0, gameRef.size.x - size.x);
    } else if (ball.position.x < position.x + size.x / 2) {
      position.x = (position.x - GameConfig.botSpeed * dt)
          .clamp(0, gameRef.size.x - size.x);
    }
  }
  
  /// Reset bot to active state
  void reset() {
    _active = true;
  }
}