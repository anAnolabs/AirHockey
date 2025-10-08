lib/
├── main.dart                    # Entry point chính
├── models/                      # Data models & configuration
│   ├── game_config.dart        # Game configuration constants
│   └── score.dart              # Score management logic
├── components/                  # Game components
│   ├── paddle.dart             # Abstract base Paddle class
│   ├── player_paddle.dart      # Player-controlled paddle
│   ├── bot_paddle.dart         # AI-controlled paddle
│   ├── ball.dart               # Ball physics & collision
│   ├── goal.dart               # Goal scoring areas
│   ├── scoreboard.dart         # Score display UI
│   ├── field_lines.dart        # Field decorations
│   └── confetti.dart           # Visual effects
├── screens/                     # UI screens & overlays
│   └── game_over_overlay.dart  # Game over screen
└── utils/                       # Utility functions
    └── collision_utils.dart    # Collision detection helpers
