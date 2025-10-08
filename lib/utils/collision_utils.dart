import 'package:flame/components.dart';

/// Utility class for collision detection and physics calculations
class CollisionUtils {
  /// Check if two PositionComponents are colliding
  static bool isColliding(PositionComponent a, PositionComponent b) {
    return a.toRect().overlaps(b.toRect());
  }
  
  /// Check if a position is within bounds
  static bool isWithinBounds(PositionComponent component, double width, double height) {
    return component.position.x >= 0 && 
           component.position.x <= width - component.size.x &&
           component.position.y >= 0 && 
           component.position.y <= height - component.size.y;
  }
  
  /// Clamp position within bounds
  static void clampToBounds(PositionComponent component, double width, double height) {
    component.position.x = component.position.x.clamp(0, width - component.size.x);
    component.position.y = component.position.y.clamp(0, height - component.size.y);
  }
  
  /// Calculate distance between two components
  static double distance(PositionComponent a, PositionComponent b) {
    final dx = a.position.x - b.position.x;
    final dy = a.position.y - b.position.y;
    return (dx * dx + dy * dy).abs();
  }
}