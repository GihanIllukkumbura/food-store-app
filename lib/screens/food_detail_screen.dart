import 'package:flutter/material.dart';
import 'dart:math' as math;

/// Custom painter for creating a star-burst discount badge
class StarBurstPainter extends CustomPainter {
  final Color color;
  final int spikes;

  StarBurstPainter({
    required this.color,
    this.spikes = 30,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final Path path = Path();
    final double centerX = size.width / 2;
    final double centerY = size.height / 2;
    final double outerRadius = size.width * 0.5;
    final double innerRadius = size.width * 0.4; // Smaller spikes

    // Create star-burst shape with 60 small triangular spikes
    for (int i = 0; i < spikes * 2; i++) {
      final double angle = (i * math.pi) / spikes;
      final double radius = (i % 2 == 0) ? outerRadius : innerRadius;
      final double x = centerX + radius * math.cos(angle);
      final double y = centerY + radius * math.sin(angle);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();

    // Draw star-burst
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Custom widget for the star-burst discount badge
class StarBurstDiscountBadge extends StatelessWidget {
  const StarBurstDiscountBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      height: 60,
      child: CustomPaint(
        painter: StarBurstPainter(
          color: const Color(0xFF4A90E2),
          spikes: 30,
        ),
        child: const Center(
          child: Text(
            '50%\nOFF',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              height: 1.0,
            ),
          ),
        ),
      ),
    );
  }
}

class FoodDetailScreen extends StatelessWidget {
  const FoodDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header with back button and title
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: const Color(0xFF2D3748),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                    const Expanded(
                      child: Center(
                        child: Text(
                          'My Places',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF2D3748),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 40),
                  ],
                ),
              ),

              // Food image with simple discount badge
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: double.infinity,
                    height: 300,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        'assets/images/primavera_rolls.jpg',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[300],
                            child: const Icon(Icons.image, size: 50),
                          );
                        },
                      ),
                    ),
                  ),
                  // Star-burst discount badge - bottom right corner, overlapping image boundary
                  const Positioned(
                    bottom: -25, // Moved further down below the image
                    right: 35, // Slightly inside from the right edge
                    child: StarBurstDiscountBadge(),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Content section
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    const Text(
                      'Primavera Rolls',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2D3748),
                      ),
                    ),

                    const SizedBox(height: 8),

                    // Time
                    Row(
                      children: [
                        const Text(
                          '25',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF2D3748),
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'min',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Description
                    const Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF6B7280),
                        height: 1.6,
                      ),
                    ),

                    const SizedBox(height: 40),

                    // Order button
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Order placed successfully!'),
                              backgroundColor: Color(0xFF4A90E2),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 100, 164, 236),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Order Now    \$12.99',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
