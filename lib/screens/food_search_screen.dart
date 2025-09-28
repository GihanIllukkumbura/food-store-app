import 'package:flutter/material.dart';
import 'dart:ui';
import 'food_detail_screen.dart';
import '../utils/constants.dart';

/// Search bar widget for food search functionality
class FoodSearchBar extends StatelessWidget {
  const FoodSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppConstants.chipGray,
        borderRadius: BorderRadius.circular(AppConstants.radiusXL),
      ),
      child: const TextField(
        decoration: InputDecoration(
          hintText: ' ',
          hintStyle: TextStyle(
            color: Color.fromARGB(255, 112, 112, 112),
            fontSize: AppConstants.fontSizeSubhead,
          ),
          prefixIcon: Icon(
            Icons.search,
            color: Color.fromARGB(255, 136, 136, 136),
            size: AppConstants.spacingXL,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: AppConstants.spacingL,
            vertical: AppConstants.spacingL,
          ),
        ),
      ),
    );
  }
}

/// Category chip widget for displaying filter options
class CategoryChip extends StatelessWidget {
  final String label;

  const CategoryChip({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.spacingL,
        vertical: AppConstants.spacingS,
      ),
      decoration: BoxDecoration(
        color: AppConstants.chipGray,
        borderRadius: BorderRadius.circular(AppConstants.spacingXL),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: AppConstants.chipTextGray,
          fontSize: AppConstants.fontSizeBody,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

/// Section header widget for consistent styling
class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 21,
        fontWeight: FontWeight.w600,
        color: Color(0xFF2D3748),
      ),
    );
  }
}

/// Main title widget with responsive text sizing
class MainTitle extends StatelessWidget {
  const MainTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Text(
      'What would\nyou like to eat?',
      style: TextStyle(
        fontSize: isLandscape ? 32 : 42,
        fontWeight: FontWeight.w800,
        color: const Color(0xFF2D3748),
        height: 1.2,
      ),
    );
  }
}

class FoodSearchScreen extends StatefulWidget {
  const FoodSearchScreen({super.key});

  @override
  State<FoodSearchScreen> createState() => _FoodSearchScreenState();
}

class _FoodSearchScreenState extends State<FoodSearchScreen> {
  final ScrollController _scrollController = ScrollController();
  final List<GlobalKey> _itemKeys = [];
  final Map<int, bool> _itemVisibility = {};

  @override
  void initState() {
    super.initState();
    // Initialize keys for restaurant items
    for (int i = 0; i < 5; i++) {
      _itemKeys.add(GlobalKey());
    }

    // Listen to scroll changes
    _scrollController.addListener(_updateItemVisibility);

    // Initial visibility calculation after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateItemVisibility();
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_updateItemVisibility);
    _scrollController.dispose();
    super.dispose();
  }

  /// Calculates visibility of items and updates blur state
  void _updateItemVisibility() {
    final RenderBox? listRenderBox = context.findRenderObject() as RenderBox?;
    if (listRenderBox == null) return;

    final screenHeight = MediaQuery.of(context).size.height;
    final safePadding = MediaQuery.of(context).padding;
    final visibleHeight = screenHeight - safePadding.top - safePadding.bottom;

    for (int i = 0; i < _itemKeys.length; i++) {
      final key = _itemKeys[i];
      final RenderBox? itemRenderBox =
          key.currentContext?.findRenderObject() as RenderBox?;

      if (itemRenderBox != null) {
        // Get item position relative to screen
        final itemPosition = itemRenderBox.localToGlobal(Offset.zero);
        final itemSize = itemRenderBox.size;

        // Calculate visible portion of the item
        final itemTop = itemPosition.dy - safePadding.top;
        final itemBottom = itemTop + itemSize.height;

        // Calculate how much of the item is visible
        final visibleTop = itemTop.clamp(0.0, visibleHeight);
        final visibleBottom = itemBottom.clamp(0.0, visibleHeight);
        final visibleItemHeight =
            (visibleBottom - visibleTop).clamp(0.0, itemSize.height);

        final visibilityPercentage = visibleItemHeight / itemSize.height;

        // Update blur state - blur if less than 50% visible
        final shouldBlur = visibilityPercentage < 0.5;

        if (_itemVisibility[i] != shouldBlur) {
          setState(() {
            _itemVisibility[i] = shouldBlur;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: isLandscape ? _buildLandscapeLayout() : _buildPortraitLayout(),
      ),
    );
  }

  /// Portrait layout with fixed header and scrollable content
  Widget _buildPortraitLayout() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          const MainTitle(),
          const SizedBox(height: 30),
          const FoodSearchBar(),
          const SizedBox(height: 15),
          _buildCategoryChips(),
          const SizedBox(height: 15),
          const SectionHeader(title: 'Popular places'),
          Expanded(
            child: _buildRestaurantList(itemCount: 5),
          ),
        ],
      ),
    );
  }

  /// Landscape layout with everything scrollable
  Widget _buildLandscapeLayout() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            const MainTitle(),
            const SizedBox(height: 20),
            const FoodSearchBar(),
            const SizedBox(height: 15),
            _buildCategoryChips(),
            const SizedBox(height: 15),
            const SectionHeader(title: 'Popular places'),
            const SizedBox(height: 10),
            // More items in landscape for better scrolling
            _buildRestaurantList(itemCount: 5, shrinkWrap: true),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  /// Builds category chips row
  Widget _buildCategoryChips() {
    return const Row(
      children: [
        CategoryChip(label: 'Fast food'),
        SizedBox(width: 12),
        CategoryChip(label: 'Ramen'),
      ],
    );
  }

  /// Builds restaurant list with visibility-based blur effect
  Widget _buildRestaurantList(
      {required int itemCount, bool shrinkWrap = false}) {
    return ListView.separated(
      controller: shrinkWrap ? null : _scrollController,
      padding: EdgeInsets.zero,
      physics: shrinkWrap
          ? const NeverScrollableScrollPhysics()
          : const BouncingScrollPhysics(),
      shrinkWrap: shrinkWrap,
      itemCount: itemCount,
      separatorBuilder: (context, index) => const SizedBox(height: 15),
      itemBuilder: (context, index) {
        final restaurantData = _getRestaurantData(index);

        // Only assign GlobalKey for scrollable lists
        if (!shrinkWrap && index < _itemKeys.length) {
          return RestaurantCard(
            key: _itemKeys[index],
            name: restaurantData['name']!,
            description: restaurantData['description']!,
            imagePath: restaurantData['image']!,
            showOpenNow: [0, 1, 2, 3].contains(index),
            shouldBlur: _itemVisibility[index] == true,
          );
        } else {
          return RestaurantCard(
            name: restaurantData['name']!,
            description: restaurantData['description']!,
            imagePath: restaurantData['image']!,
            showOpenNow: [0, 1, 2, 3].contains(index),
            shouldBlur: false,
          );
        }
      },
    );
  }

  /// Returns restaurant data based on index
  Map<String, String> _getRestaurantData(int index) {
    return AppConstants
        .sampleRestaurants[index % AppConstants.sampleRestaurants.length];
  }
}

/// Enhanced restaurant card widget with modular components
class RestaurantCard extends StatelessWidget {
  const RestaurantCard({
    super.key,
    required this.name,
    required this.description,
    required this.imagePath,
    required this.showOpenNow,
    this.shouldBlur = false,
  });

  final String name;
  final String description;
  final String imagePath;
  final bool showOpenNow;
  final bool shouldBlur;

  @override
  Widget build(BuildContext context) {
    Widget cardContent = GestureDetector(
      onTap: () => _handleTap(context),
      child: Container(
        decoration: _cardDecoration,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (showOpenNow) const OpenNowBadge(),
            RestaurantImage(imagePath: imagePath),
            RestaurantInfo(name: name, description: description),
          ],
        ),
      ),
    );

    // Apply blur effect if needed
    if (shouldBlur) {
      return ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
          child: Opacity(
            opacity: 0.6,
            child: cardContent,
          ),
        ),
      );
    }

    return cardContent;
  }

  /// Handles card tap with error handling
  void _handleTap(BuildContext context) {
    debugPrint('Card tapped - attempting navigation to $name');
    try {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const FoodDetailScreen(),
        ),
      );
    } catch (e) {
      debugPrint('Navigation error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Unable to open $name details'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  /// Card decoration - transparent to blend with background
  BoxDecoration get _cardDecoration => const BoxDecoration(
        color: Color(0xFFF8F9FA), // Same as app background
        // No border radius, no shadow for seamless blending
      );
}

/// "Open Now!" badge component
class OpenNowBadge extends StatelessWidget {
  const OpenNowBadge({super.key});

  @override
  Widget build(BuildContext context) {
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
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

/// Restaurant image component with error handling
class RestaurantImage extends StatelessWidget {
  final String imagePath;

  const RestaurantImage({
    super.key,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.grey[300], // Fallback color
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: Colors.grey[300],
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.restaurant, size: 40, color: Colors.grey),
                    SizedBox(height: 8),
                    Text(
                      'Image not available',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

/// Restaurant information component
class RestaurantInfo extends StatelessWidget {
  final String name;
  final String description;

  const RestaurantInfo({
    super.key,
    required this.name,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(1, 5, 1, 5),
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
              overflow: TextOverflow.ellipsis,
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
