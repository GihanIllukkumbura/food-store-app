import 'package:flutter/material.dart';
import 'food_detail_screen.dart';
// import 'food_detail_screen_simple.dart';  // For testing

class FoodSearchScreen extends StatefulWidget {
  const FoodSearchScreen({super.key});

  @override
  State<FoodSearchScreen> createState() => _FoodSearchScreenState();
}

class _FoodSearchScreenState extends State<FoodSearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              // Title
              const Text(
                'What would\nyou like to eat?',
                style: TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF2D3748),
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 30),
              // Search bar
              Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 218, 218, 218),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: ' ',
                    hintStyle: TextStyle(
                      color: Color.fromARGB(255, 112, 112, 112),
                      fontSize: 16,
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Color.fromARGB(255, 136, 136, 136),
                      size: 20,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              // Recent search chips
              Row(
                children: [
                  _buildRecentSearchChip('Fast food'),
                  const SizedBox(width: 12),
                  _buildRecentSearchChip('Ramen'),
                ],
              ),
              const SizedBox(height: 15),
              // Popular places header
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Popular places',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF2D3748),
                    ),
                  ),
                ],
              ),
              // const SizedBox(height: 2),
              // Popular places list - Optimized with ListView.separated
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.zero,
                  physics: const BouncingScrollPhysics(),
                  itemCount: 3,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 15),
                  itemBuilder: (context, index) => const RestaurantCard(
                    name: 'Traditional Pasta',
                    description: 'Lunch • Dinner • Pasta',
                    imagePath: 'assets/images/pasta_dish.jpg',
                    showOpenNow: true,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds a non-selectable recent search chip with consistent gray styling
  Widget _buildRecentSearchChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 218, 218, 218),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Color.fromARGB(255, 110, 110, 110),
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

/// A reusable restaurant card widget following Flutter best practices
class RestaurantCard extends StatelessWidget {
  const RestaurantCard({
    super.key,
    required this.name,
    required this.description,
    required this.imagePath,
    required this.showOpenNow,
  });

  final String name;
  final String description;
  final String imagePath;
  final bool showOpenNow;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        debugPrint('Card tapped - attempting navigation');
        try {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const FoodDetailScreen(),
            ),
          );
        } catch (e) {
          debugPrint('Navigation error: $e');
        }
      },
      child: Container(
        decoration: _cardDecoration,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // "Open Now!" section above the image
            if (showOpenNow) _buildOpenNowSection(),
            _buildImageSection(),
            _buildContentSection(),
          ],
        ),
      ),
    );
  }

  /// Card decoration - transparent to blend with background
  BoxDecoration get _cardDecoration => const BoxDecoration(
        color: Color(0xFFF8F9FA), // Same as app background
        // No border radius, no shadow for seamless blending
      );

  /// Builds the image section without overlay
  Widget _buildImageSection() {
    return Container(
      height: 120,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  /// Builds the "Open Now!" section positioned above the image
  Widget _buildOpenNowSection() {
    return const Padding(
      padding: EdgeInsets.fromLTRB(1, 1, 1, 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            'Open Now!',
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF4A90E2),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the content section with name and description on the same line
  Widget _buildContentSection() {
    return Padding(
      padding: EdgeInsets.fromLTRB(1, 5, 1, 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2D3748),
              ),
            ),
          ),
          Text(
            description,
            style: const TextStyle(
              fontSize: 14,
              color: Color.fromARGB(255, 100, 100, 100),
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
