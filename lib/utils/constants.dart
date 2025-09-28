import 'package:flutter/material.dart';

/// App-wide constants for consistent styling and configuration
class AppConstants {
  // Private constructor to prevent instantiation
  AppConstants._();

  /// Color constants
  static const Color primaryBlue = Color(0xFF4A90E2);
  static const Color textDark = Color(0xFF2D3748);
  static const Color textGray = Color(0xFF6B7280);
  static const Color textLightGray = Color.fromARGB(255, 100, 100, 100);
  static const Color backgroundGray = Color(0xFFF8F9FA);
  static const Color chipGray = Color.fromARGB(255, 218, 218, 218);
  static const Color chipTextGray = Color.fromARGB(255, 110, 110, 110);

  /// Spacing constants
  static const double spacingXS = 4.0;
  static const double spacingS = 8.0;
  static const double spacingM = 12.0;
  static const double spacingL = 16.0;
  static const double spacingXL = 20.0;
  static const double spacingXXL = 24.0;
  static const double spacingLarge = 30.0;
  static const double spacingHuge = 40.0;

  /// Border radius constants
  static const double radiusS = 8.0;
  static const double radiusM = 12.0;
  static const double radiusL = 16.0;
  static const double radiusXL = 20.0;

  /// Font size constants
  static const double fontSizeCaption = 12.0;
  static const double fontSizeBody = 14.0;
  static const double fontSizeSubhead = 16.0;
  static const double fontSizeTitle = 18.0;
  static const double fontSizeHeading = 21.0;
  static const double fontSizeLarge = 28.0;
  static const double fontSizeDisplay = 32.0;
  static const double fontSizeHero = 42.0;

  /// Animation durations
  static const Duration animationFast = Duration(milliseconds: 150);
  static const Duration animationMedium = Duration(milliseconds: 300);
  static const Duration animationSlow = Duration(milliseconds: 500);

  /// Image paths
  static const String imagePastaBg = 'assets/images/pasta_bg.jpg';
  static const String imagePastaDish = 'assets/images/pasta_dish.jpg';
  static const String imagePrimaveraRolls = 'assets/images/primavera_rolls.jpg';

  /// Restaurant sample data
  static const List<Map<String, String>> sampleRestaurants = [
    {
      'name': 'Traditional Pasta',
      'description': 'Lunch • Dinner • Pasta',
      'image': imagePastaDish,
    },
    {
      'name': 'Traditional Pasta',
      'description': 'Lunch • Dinner • Pasta',
      'image': imagePastaDish,
    },
    {
      'name': 'Traditional Pasta',
      'description': 'Lunch • Dinner • Pasta',
      'image': imagePastaDish,
    },
    {
      'name': 'Traditional Pasta',
      'description': 'Lunch • Dinner • Pasta',
      'image': imagePastaDish,
    },
    {
      'name': 'Traditional Pasta',
      'description': 'Lunch • Dinner • Pasta',
      'image': imagePastaDish,
    },
  ];
}
