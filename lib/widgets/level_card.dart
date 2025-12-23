
import 'package:flutter/material.dart';

class LevelCard extends StatelessWidget {
  final int level;

  const LevelCard({super.key, required this.level});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: PentagonClipper(),
      child: Container(
        color: _getColorForLevel(level),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (starIndex) {
                return Icon(
                  starIndex < _getStarsForLevel(level)
                      ? Icons.star
                      : Icons.star_border,
                  color: Colors.yellow,
                );
              }),
            ),
            const SizedBox(height: 10),
            Text(
              'Level ${level.toString().padLeft(2, '0')}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (level == 5) ...[
              const SizedBox(height: 10),
              const Icon(Icons.lock, color: Colors.white70),
            ]
          ],
        ),
      ),
    );
  }

  Color _getColorForLevel(int level) {
    switch (level) {
      case 1:
        return const Color(0xFF6A4CEB);
      case 2:
        return Colors.blue;
      case 3:
        return Colors.orange;
      case 4:
        return Colors.green;
      case 5:
        return Colors.grey.withOpacity(0.5);
      default:
        return Colors.purple;
    }
  }

  int _getStarsForLevel(int level) {
    switch (level) {
      case 1:
        return 3;
      case 2:
        return 2;
      case 3:
        return 3;
      case 4:
        return 2;
      default:
        return 0;
    }
  }
}

class PentagonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(size.width / 2, 0); // Top point
    path.lineTo(size.width, size.height * 0.38); // Top right
    path.lineTo(size.width * 0.8, size.height); // Bottom right
    path.lineTo(size.width * 0.2, size.height); // Bottom left
    path.lineTo(0, size.height * 0.38); // Top left
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
