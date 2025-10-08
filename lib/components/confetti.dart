import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import '../models/game_config.dart';

/// Individual confetti particle
class ConfettiParticle {
  Vector2 position;
  final Color color;
  final double speed;
  final Paint _paint = Paint();
  
  ConfettiParticle({
    required this.position,
    required this.color, 
    required this.speed,
  }) {
    _paint.color = color;
  }
  
  void render(Canvas canvas) {
    canvas.drawCircle(
      Offset(position.x, position.y), 
      GameConfig.confettiParticleSize, 
      _paint,
    );
  }
  
  void update(double dt) {
    position.y += speed;
  }
}

/// Confetti effect component
class Confetti extends Component with HasGameRef {
  final List<ConfettiParticle> _particles = [];
  final Random _random = Random();
  int _framesRemaining = GameConfig.confettiDuration;
  final bool isWin;
  
  Confetti({required this.isWin});
  
  @override
  Future<void> onLoad() async {
    _generateParticles();
  }
  
  void _generateParticles() {
    final width = gameRef.size.x;
    final height = gameRef.size.y;
    
    for (int i = 0; i < GameConfig.confettiParticleCount; i++) {
      final color = isWin
          ? Colors.primaries[_random.nextInt(Colors.primaries.length)]
          : Colors.red.withOpacity(_random.nextDouble() * 0.5 + 0.5);
      
      final speed = _random.nextDouble() * 
          (GameConfig.confettiMaxSpeed - GameConfig.confettiMinSpeed) + 
          GameConfig.confettiMinSpeed;
      
      _particles.add(ConfettiParticle(
        position: Vector2(
          _random.nextDouble() * width,
          _random.nextDouble() * height / 2,
        ),
        color: color,
        speed: speed,
      ));
    }
  }
  
  @override
  void render(Canvas canvas) {
    for (final particle in _particles) {
      particle.render(canvas);
    }
  }
  
  @override
  void update(double dt) {
    for (final particle in _particles) {
      particle.update(dt);
    }
    
    if (_framesRemaining-- <= 0) {
      removeFromParent();
    }
  }
}