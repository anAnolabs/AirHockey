import 'package:flutter/material.dart';
import '../models/game_config.dart';

/// Game Over overlay screen widget
class GameOverOverlay extends StatelessWidget {
  final bool playerWon;
  final VoidCallback onRestart;
  
  const GameOverOverlay({
    super.key,
    required this.playerWon,
    required this.onRestart,
  });
  
  @override
  Widget build(BuildContext context) {
    final text = playerWon ? "You Win!" : "You Lose!";
    final color = playerWon ? Colors.yellow : Colors.red;
    
    return Stack(
      children: [
        // Semi-transparent background
        Container(
          color: Colors.black.withOpacity(0.8),
        ),
        
        // Game over content
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Game over text
              Text(
                text,
                style: TextStyle(
                  fontSize: GameConfig.gameOverFontSize,
                  color: color,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      offset: const Offset(2, 2),
                      blurRadius: 4,
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 30),
              
              // Restart button
              ElevatedButton(
                onPressed: onRestart,
                style: ElevatedButton.styleFrom(
                  backgroundColor: color,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30, 
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "Try Again",
                  style: TextStyle(
                    fontSize: GameConfig.buttonFontSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}