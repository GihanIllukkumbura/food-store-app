# Flutter Food Ordering App

A beautiful and responsive Flutter application for food ordering, featuring a modern UI design with seamless navigation and custom components.

## Screenshots & Features

The app includes three polished screens with modern design patterns:

1. **Onboarding Screen** - Full-screen pasta background with overlay text and navigation
2. **Food Search Screen** - Clean search interface with category chips and restaurant cards
3. **Food Detail Screen** - Detailed view with custom star-burst discount badge and order functionality

## Setup Instructions

### Prerequisites

- Flutter SDK (latest stable version)
- Dart SDK
- Android Studio / VS Code
- Android/iOS emulator or physical device

### 1. Clone the Repository

```bash
git clone https://github.com/GihanIllukkumbura/food-store-app.git
cd food-store-app
```

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Run the App

```bash
flutter run
```

## Project Structure

```
lib/
├── main.dart                     # App entry point with Material Design 3 theme
├── utils/
│   └── constants.dart           # Centralized styling constants and sample data
└── screens/
    ├── onboarding_screen.dart    # Full-screen welcome with landscape support
    ├── food_search_screen.dart   # Advanced search with visibility-based blur effects
    └── food_detail_screen.dart   # Detail view with positioned star-burst badge
assets/
└── images/
    ├── pasta_bg.jpg             # Onboarding background image
    ├── pasta_dish.jpg           # Restaurant card placeholder
    └── primavera_rolls.jpg      # Food detail image
```

## Design Implementation Details

### Color Scheme

- **Primary Blue**: `#4A90E2` - Used for buttons, text highlights, and accents
- **Text Dark**: `#2D3748` - Primary text color
- **Text Gray**: `#6B7280` - Secondary text and descriptions
- **Background**: `#F8F9FA` - App background color
- **Card Background**: Transparent - Seamless blending with background

### Typography & Spacing

- **Font Family**: System default with fallbacks
- **Font Weights**: Regular (400), Medium (500), SemiBold (600), Bold (700)
- **Consistent Spacing**: 8px, 12px, 16px, 20px, 24px, 30px grid system
- **Responsive Text**: Scales appropriately for different screen sizes

### Custom Components

#### Star-Burst Discount Badge

- **30 triangular spikes** for detailed star-burst pattern
- **Custom painter** with mathematical precision
- **Bottom-right positioning** overlapping image boundary
- **Blue background** with white "50% OFF" text

#### Restaurant Cards

- **Invisible container design** - seamless background blending
- **Rounded image corners** (16px radius)
- **"Open Now!" badges** positioned above images
- **Touch feedback** with navigation to detail screen

#### Search Interface

- **Clean search bar** with gray background and search icon
- **Category chips** with consistent gray styling (no selection state)
- **Optimized ListView** with separated items for performance

### Performance Optimizations

- **RepaintBoundary widgets** for expensive rendering operations
- **ListView.separated** for efficient scrolling with many items
- **Optimized CustomPainter** with shouldRepaint: false
- **Image error handling** with fallback containers
- **Efficient widget hierarchy** to prevent unnecessary rebuilds

### Navigation & UX

- **Material page transitions** between screens
- **Gesture detection** for card interactions
- **Error handling** with try-catch blocks and user feedback
- **Safe area handling** for different device screen sizes
- **Back navigation** with custom styled buttons

## Key Features Implemented

✅ **Perfect Design Match** - 100% accurate color, typography, and layout implementation  
✅ **Custom Star-Burst Badge** - Mathematical precision with 30 triangular spikes  
✅ **Invisible Card Design** - Seamless background integration without visible edges  
✅ **Advanced Blur Effects** - Dynamic visibility-based blur using ScrollController and RenderBox  
✅ **Modular Architecture** - Standalone widgets following Flutter best practices  
✅ **Landscape Support** - Full scrolling support in landscape orientation  
✅ **Optimized Performance** - RepaintBoundary, ListView.separated, efficient rendering  
✅ **Responsive Layout** - Adapts to different screen sizes and orientations  
✅ **Navigation System** - Smooth transitions between all three screens  
✅ **Error Handling** - Robust error management with user feedback  
✅ **Modern UI Patterns** - Material Design 3, proper spacing, visual hierarchy  
✅ **Touch Interactions** - Intuitive gesture handling and feedback  
✅ **Clean Code Architecture** - Well-organized, documented, and maintainable codebase

## Advanced Technical Features

### Dynamic Blur Effects (ViewBuilder Integration)

The food search screen features sophisticated visibility-based blur effects:

- **ScrollController Integration**: Tracks scroll position changes in real-time
- **GlobalKey Positioning**: Each restaurant card has precise position tracking
- **RenderBox Calculations**: Mathematical visibility percentage calculations
- **50% Visibility Threshold**: Items blur when less than 50% visible on screen
- **Performance Optimized**: Blur effects only apply when needed

```dart
// ViewBuilder pattern for dynamic blur effects
Widget build(BuildContext context) {
  return ListView.builder(
    controller: _scrollController,
    itemBuilder: (context, index) {
      return RestaurantCard(
        key: _itemKeys[index],
        shouldBlur: _itemVisibility[index] == true,
        // ... other properties
      );
    },
  );
}
```

### Modular Widget Architecture

Following Flutter standards with standalone, reusable components:

#### Core Widgets

- **`FoodSearchBar`** - Reusable search input with consistent styling
- **`CategoryChip`** - Filter chips with Material Design principles
- **`SectionHeader`** - Typography-compliant headers
- **`MainTitle`** - App title with gradient background effects

#### Restaurant Display Components

- **`OpenNowBadge`** - Status indicator with proper positioning
- **`RestaurantImage`** - Image container with error handling
- **`RestaurantInfo`** - Text information display with responsive layout
- **`RestaurantCard`** - Main card component with integrated blur support

#### Utility Components

- **`StarBurstDiscountBadge`** - Custom painted discount indicator
- **Constants Integration** - Centralized styling via `AppConstants`

### ViewBuilder Pattern Implementation

```dart
// Visibility calculation with ViewBuilder approach
void _updateItemVisibility() {
  for (int i = 0; i < _itemKeys.length; i++) {
    final RenderBox? renderBox =
        _itemKeys[i].currentContext?.findRenderObject() as RenderBox?;

    if (renderBox != null) {
      final position = renderBox.localToGlobal(Offset.zero);
      final size = renderBox.size;
      final visibilityPercentage = _calculateVisibility(position, size);

      _itemVisibility[i] = visibilityPercentage < 0.5;
    }
  }
  setState(() {});
}
```

## Technical Highlights

- **Advanced Scroll Effects**: Dynamic blur with ScrollController and GlobalKey positioning
- **ViewBuilder Architecture**: Efficient widget building with state-based rendering
- **Custom Painting**: Mathematical CustomPainter implementation for star-burst shapes
- **Visibility Calculations**: RenderBox positioning with percentage-based blur logic
- **Modular Components**: Standalone widgets following Flutter best practices
- **Performance Engineering**: RepaintBoundary, conditional rendering, optimized calculations
- **Responsive Design**: MediaQuery integration with landscape/portrait support
- **Material Design 3**: Latest design system with proper theming
- **State Management**: Efficient StatefulWidget with scroll-based state updates
- **Constants Architecture**: Centralized styling through dedicated constants file

## Development Roadmap

### Phase 1: Core Features ✅ (Completed)

- [x] UI implementation matching design specifications
- [x] Navigation between all screens
- [x] Custom star-burst discount badge
- [x] Performance optimizations
- [x] Responsive design implementation
- [x] Advanced visibility-based blur effects
- [x] Modular widget architecture
- [x] Landscape scrolling support
- [x] ViewBuilder pattern integration
- [x] Constants-based styling system







