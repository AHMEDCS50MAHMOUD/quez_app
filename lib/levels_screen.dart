
import 'package:flutter/material.dart';

class LevelsScreen extends StatelessWidget {
  const LevelsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1F1147),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Levels', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.9,
          ),
          itemCount: 5,
          itemBuilder: (context, index) {
            return LevelCard(level: index + 1);
          },
        ),
      ),
    );
  }
}

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
    path.moveTo(size.width / 2, 0);
    path.lineTo(size.width, size.height * 0.38);
    path.lineTo(size.width * 0.8, size.height);
    path.lineTo(size.width * 0.2, size.height);
    path.lineTo(0, size.height * 0.38);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
