import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import '../models/game_config.dart';
import '../utils/collision_utils.dart';
import 'paddle.dart';
import 'player_paddle.dart';
import 'bot_paddle.dart';

/// Ball component with physics and collision detection
class Ball extends PositionComponent with HasGameRef {
  Vector2 velocity = Vector2.zero();
  final Random _random = Random();
  
  // Collision detection callback
  void Function(bool playerScored)? onGoalHit;
  
  Ball({Vector2? initialPosition}) : super(
    size: Vector2.all(GameConfig.ballSize),
    position: initialPosition ?? Vector2(200, 300),
  ) {
    _initializeVelocity();
  }
  
  void _initializeVelocity() {
    final direction = _random.nextBool() ? 1 : -1;
    velocity = Vector2(
      direction * GameConfig.ballInitialSpeed,
      (_random.nextBool() ? 1 : -1) * GameConfig.ballInitialSpeed,
    );
  }
  
  @override
  void update(double dt) {
    // Update position based on velocity
    position += velocity * dt;
    
    // Handle wall collisions (left and right walls)
    if (position.x <= 0 || position.x >= gameRef.size.x - size.x) {
      velocity.x = -velocity.x;
      CollisionUtils.clampToBounds(this, gameRef.size.x, gameRef.size.y);
    }
    
    // Handle ceiling and floor collisions  
    if (position.y <= 0 || position.y >= gameRef.size.y - size.y) {
      velocity.y = -velocity.y;
      CollisionUtils.clampToBounds(this, gameRef.size.x, gameRef.size.y);
    }
    
    // Check paddle collisions
    _checkPaddleCollisions();
    
    // Check goal collisions
    _checkGoalCollisions();
  }
  
  void _checkPaddleCollisions() {
    // Find paddles in the game
    final paddles = gameRef.children.whereType<Paddle>();
    
    for (final paddle in paddles) {
      if (CollisionUtils.isColliding(this, paddle)) {
        if (paddle is PlayerPaddle) {
          // Hit player paddle - ball goes up
          velocity.y = -velocity.y.abs();
        } else if (paddle is BotPaddle) {
          // Hit bot paddle - ball goes down
          velocity.y = velocity.y.abs();
        }
        
        // Add some randomness to the bounce angle
        final randomFactor = (_random.nextDouble() - 0.5) * 50;
        velocity.x += randomFactor;
      }
    }
  }
  
  void _checkGoalCollisions() {
    // Check if ball hit player goal (top of screen)
    if (position.y <= 0) {
      onGoalHit?.call(false); // Opponent scored
    }
    
    // Check if ball hit opponent goal (bottom of screen)
    if (position.y >= gameRef.size.y - size.y) {
      onGoalHit?.call(true); // Player scored
    }
  }
  
  /// Reset ball to center with random velocity
  void reset() {
    position = Vector2(gameRef.size.x / 2 - size.x / 2, gameRef.size.y / 2 - size.y / 2);
    _initializeVelocity();
  }
  
  @override
  void render(Canvas canvas) {
    final paint = Paint()..color = Colors.white;
    canvas.drawCircle(
      Offset(size.x / 2, size.y / 2), 
      size.x / 2, 
      paint,
    );
  }
}