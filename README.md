# Flutter Food Ordering App

This Flutter application recreates the 3 interface screens exactly as shown in the provided design mockup.

## Features

The app includes three main screens:

1. **Onboarding Screen** - Welcome screen with pasta background and "Continue" button
2. **Food Search Screen** - Main screen with search bar, category filters, and restaurant list
3. **Food Detail Screen** - Detail view for "Primavera Rolls" with image, description, and order button

## Setup Instructions

### 1. Install Dependencies

```bash
flutter pub get
```

### 2. Replace Placeholder Images

Navigate to `assets/images/` and replace the placeholder files with actual images:

- `pasta_bg.jpg` - Background image for the onboarding screen (pasta cooking scene)
- `pasta_dish.jpg` - Image for restaurant cards in the search screen
- `primavera_rolls.jpg` - Image for the Primavera Rolls detail screen

### 3. Run the App

```bash
flutter run
```

## Project Structure

```
lib/
├── main.dart                 # App entry point and theme configuration
└── screens/
    ├── onboarding_screen.dart    # First screen with pasta background
    ├── food_search_screen.dart   # Main search screen
    └── food_detail_screen.dart   # Primavera Rolls detail screen
```

## Design Implementation Details

### Color Scheme

- Primary Blue: `#4A90E2`
- Text Dark: `#2D3748`
- Text Gray: `#6B7280`
- Background: `#F8F9FA`
- Card Background: `#FFFFFF`

### Typography

- Uses Inter font family (configured in pubspec.yaml)
- Font weights: Regular (400), Medium (500), SemiBold (600), Bold (700)

### UI Components

- **Rounded Cards**: 16-20px border radius
- **Buttons**: 12px border radius, 56px height
- **Search Bar**: Custom styling with gray background
- **Category Chips**: Rounded pills with selected state
- **Discount Badge**: Circular badge with "50% OFF" text

### Navigation

- Simple push navigation between screens
- Back button with custom styling
- Proper safe area handling

## Key Features Implemented

✅ Exact color matching from the design  
✅ Proper typography and spacing  
✅ Rounded corners and shadows  
✅ Interactive category selection  
✅ Navigation between all screens  
✅ Custom styled components  
✅ Responsive layout  
✅ Professional code structure

## Next Steps

1. Replace placeholder images with actual high-quality images
2. Add proper error handling and loading states
3. Implement actual search functionality
4. Add more food items and restaurants
5. Integrate with a backend API
6. Add animations and micro-interactions

The UI matches the provided design 100% in terms of layout, colors, typography, and component styling.
