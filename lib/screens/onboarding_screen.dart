import 'package:flutter/material.dart';
import 'food_search_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          // Full screen background image - Optimized with RepaintBoundary
          RepaintBoundary(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/pasta_bg.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          // Dark overlay gradient - Optimized with RepaintBoundary
          RepaintBoundary(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.2),
                    Colors.black.withOpacity(0.6),
                  ],
                ),
              ),
            ),
          ),
          // Content with responsive layout
          SafeArea(
            child: isLandscape
                ? _buildLandscapeLayout(screenHeight)
                : _buildPortraitLayout(),
          ),
        ],
      ),
    );
  }

  /// Portrait layout with content at bottom
  Widget _buildPortraitLayout() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Order your\nhealthy food\neasily',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Lorem ipsum dolor sit amet,\nconsectetur adipiscing elit, sed\ndiam nonummy nibh',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 30),
              _buildContinueButton(),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ],
    );
  }

  /// Landscape layout with scrollable content and center alignment
  Widget _buildLandscapeLayout(double screenHeight) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: screenHeight),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Order your\nhealthy food\neasily',
                style: TextStyle(
                  color: Colors.white,
                  fontSize:
                      screenHeight < 400 ? 28 : 32, // Responsive font size
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                ),
              ),
              SizedBox(height: screenHeight < 400 ? 12 : 16),
              const Text(
                'Lorem ipsum dolor sit amet,\nconsectetur adipiscing elit, sed\ndiam nonummy nibh',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                  height: 1.4,
                ),
              ),
              SizedBox(height: screenHeight < 400 ? 20 : 24),
              _buildContinueButton(),
            ],
          ),
        ),
      ),
    );
  }

  /// Reusable continue button widget
  Widget _buildContinueButton() {
    return Builder(
      builder: (context) => SizedBox(
        width: double.infinity,
        height: 56,
        child: ElevatedButton(
          onPressed: () => _navigateToFoodSearch(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 100, 164, 236),
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text(
            'Continue',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  /// Optimized navigation method
  void _navigateToFoodSearch(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const FoodSearchScreen(),
        settings: const RouteSettings(name: '/food-search'),
      ),
    );
  }
}
