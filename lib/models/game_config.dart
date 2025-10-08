/// Configuration class for game settings
class GameConfig {
  // Game dimensions and bounds
  static const double ballSize = 20.0;
  static const double paddleWidth = 80.0;
  static const double paddleHeight = 20.0;
  static const double goalHeight = 10.0;
  
  // Game physics
  static const double ballInitialSpeed = 150.0;
  static const double botSpeed = 100.0;
  
  // Game rules
  static const int maxScore = 3;
  static const int confettiParticleCount = 100;
  static const int confettiDuration = 100; // frames
  
  // Player positions
  static const double playerYOffset = 80.0;
  static const double botYOffset = 40.0;
  
  // UI settings
  static const double scoreFontSize = 32.0;
  static const double gameOverFontSize = 48.0;
  static const double buttonFontSize = 24.0;
  
  // Field settings
  static const double fieldLineWidth = 2.0;
  static const double centerCircleSmallRadiusFactor = 24.0; // size.x / 24
  static const double centerCircleBigRadiusFactor = 8.0;    // size.x / 8
  static const double goalWidthFactor = 4.0; // size.x / 4
  
  // Confetti settings
  static const double confettiParticleSize = 5.0;
  static const double confettiMinSpeed = 2.0;
  static const double confettiMaxSpeed = 5.0;
}