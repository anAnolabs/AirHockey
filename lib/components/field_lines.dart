import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import '../models/game_config.dart';

/// Field lines and decorative elements for the game field
class FieldLines extends Component with HasGameRef {
  @override
  void render(Canvas canvas) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = GameConfig.fieldLineWidth;
    
    final midX = gameRef.size.x / 2;
    final midY = gameRef.size.y / 2;
    
    // Draw center line
    canvas.drawLine(
      Offset(0, midY), 
      Offset(gameRef.size.x, midY), 
      paint,
    );
    
    // Draw center circles
    final smallRadius = gameRef.size.x / GameConfig.centerCircleSmallRadiusFactor;
    final bigRadius = gameRef.size.x / GameConfig.centerCircleBigRadiusFactor;
    
    // Fill small center circle
    paint.style = PaintingStyle.fill;
    canvas.drawCircle(Offset(midX, midY), smallRadius, paint);
    
    // Draw big center circle outline
    paint.style = PaintingStyle.stroke;
    canvas.drawCircle(Offset(midX, midY), bigRadius, paint);
    
    // Draw goal areas (optional decorative elements)
    _drawGoalAreas(canvas, paint);
  }
  
  void _drawGoalAreas(Canvas canvas, Paint paint) {
    final goalWidth = gameRef.size.x / GameConfig.goalWidthFactor;
    final goalX = gameRef.size.x / 2 - goalWidth / 2;
    
    // Top goal area
    canvas.drawRect(
      Rect.fromLTWH(goalX, 0, goalWidth, GameConfig.goalHeight * 3),
      paint,
    );
    
    // Bottom goal area  
    canvas.drawRect(
      Rect.fromLTWH(
        goalX, 
        gameRef.size.y - GameConfig.goalHeight * 3, 
        goalWidth, 
        GameConfig.goalHeight * 3,
      ),
      paint,
    );
  }
}