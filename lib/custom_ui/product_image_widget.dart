import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ProductImageWidget extends StatelessWidget {
  final String productTitle;
  final String imageUrl;

  const ProductImageWidget({
    super.key,
    required this.productTitle,
    required this.imageUrl,
  });

  IconData _getIconForProduct(String title) {
    final titleLower = title.toLowerCase();

    if (titleLower.contains('cap') || titleLower.contains('hat')) {
      return CupertinoIcons.square_on_square;
    } else if (titleLower.contains('shoe') ||
        titleLower.contains('sneaker') ||
        titleLower.contains('sandal')) {
      return CupertinoIcons.square_on_square;
    } else if (titleLower.contains('shirt') ||
        titleLower.contains('dress') ||
        titleLower.contains('jeans')) {
      return CupertinoIcons.square_on_square;
    } else if (titleLower.contains('watch') || titleLower.contains('sport')) {
      return CupertinoIcons.stopwatch;
    } else if (titleLower.contains('backpack') || titleLower.contains('bag')) {
      return CupertinoIcons.bag;
    } else if (titleLower.contains('wallet')) {
      return CupertinoIcons.creditcard;
    } else if (titleLower.contains('sunglasses')) {
      return CupertinoIcons.square_on_square;
    } else if (titleLower.contains('earbuds') || titleLower.contains('speaker')) {
      return CupertinoIcons.speaker_2;
    } else if (titleLower.contains('phone')) {
      return CupertinoIcons.phone;
    } else if (titleLower.contains('cable') || titleLower.contains('charger')) {
      return CupertinoIcons.bolt;
    } else if (titleLower.contains('power')) {
      return CupertinoIcons.battery_100;
    } else if (titleLower.contains('lamp') || titleLower.contains('light')) {
      return CupertinoIcons.lightbulb;
    } else if (titleLower.contains('coffee')) {
      return CupertinoIcons.square_on_square;
    } else if (titleLower.contains('bed') || titleLower.contains('pillow')) {
      return CupertinoIcons.square_on_square;
    } else if (titleLower.contains('yoga') || titleLower.contains('mat')) {
      return CupertinoIcons.square_on_square;
    } else if (titleLower.contains('dumbbell')) {
      return CupertinoIcons.square_on_square;
    } else if (titleLower.contains('bottle') || titleLower.contains('water')) {
      return CupertinoIcons.drop;
    } else if (titleLower.contains('tent') || titleLower.contains('camping')) {
      return CupertinoIcons.square_on_square;
    } else if (titleLower.contains('block') || titleLower.contains('puzzle')) {
      return CupertinoIcons.square_on_square;
    } else if (titleLower.contains('car') || titleLower.contains('remote')) {
      return CupertinoIcons.square_on_square;
    } else if (titleLower.contains('horse') || titleLower.contains('toy')) {
      return CupertinoIcons.square_on_square;
    }

    return CupertinoIcons.square_on_square;
  }

  Color _getColorForProduct(String title) {
    final hash = title.hashCode.abs();
    final colors = [
      const Color(0xFFFF6B6B),
      const Color(0xFF4ECDC4),
      const Color(0xFF45B7D1),
      const Color(0xFFFFA07A),
      const Color(0xFF98D8C8),
      const Color(0xFFF7DC6F),
      const Color(0xFFBB8FCE),
      const Color(0xFF85C1E2),
      const Color(0xFFF8B7B7),
      const Color(0xFFA8E6CF),
    ];
    return colors[hash % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    final color = _getColorForProduct(productTitle);
    final icon = _getIconForProduct(productTitle);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            color,
            color.withOpacity(0.7),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Background pattern
          Positioned(
            top: -20,
            right: -20,
            child: Icon(
              icon,
              size: 120,
              color: Colors.white.withOpacity(0.1),
            ),
          ),
          // Center icon
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 50,
                  color: Colors.white,
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    productTitle,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
