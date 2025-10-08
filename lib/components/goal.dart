import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import '../models/game_config.dart';

/// Goal component for scoring areas
class Goal extends PositionComponent with HasGameRef {
  final bool isPlayerGoal;
  
  Goal({required this.isPlayerGoal}) : super();
  
  @override
  void onMount() {
    super.onMount();
    _updatePosition();
  }
  
  void _updatePosition() {
    final goalWidth = gameRef.size.x / GameConfig.goalWidthFactor;
    final posY = isPlayerGoal ? gameRef.size.y - GameConfig.goalHeight : 0.0;
    
    size = Vector2(goalWidth, GameConfig.goalHeight);
    position = Vector2(gameRef.size.x / 2 - size.x / 2, posY);
  }
  
  @override
  void render(Canvas canvas) {
    final paint = Paint()..color = Colors.green;
    canvas.drawRect(size.toRect(), paint);
  }
}