import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'paddle.dart';

/// Player-controlled paddle
class PlayerPaddle extends Paddle {
  PlayerPaddle(Vector2 position) 
    : super(position: position, color: Colors.blue);
  
  @override
  void updatePaddle(double dt) {
    // Player paddle is controlled by user input, no automatic updates needed
    // Movement is handled in the game's drag callbacks
  }
  
  /// Move paddle to specific x position (used by drag controls)
  void moveTo(double x, double gameWidth) {
    position.x = (x - size.x / 2).clamp(0, gameWidth - size.x);
  }
}