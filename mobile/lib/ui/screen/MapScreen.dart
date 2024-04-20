import 'package:flutter/material.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  // List to hold the positions of drawn objects
  List<Offset> objectPositions = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: InteractiveViewer(
            boundaryMargin: const EdgeInsets.all(20.0),
            minScale: 0.1,
            maxScale: 5.6,
            child: Stack(
              children: [
                Center(
                  child: Image.asset('assets/map.png'), // Center the image
                ),
                GestureDetector(
                  onTapUp: (details) {
                    setState(() {
                      // Add the position where user tapped
                      objectPositions.add(details.localPosition);
                    });
                  },
                ),
                CustomPaint(
                  // Use CustomPaint to draw objects on top of the image
                  painter: ObjectPainter(objectPositions),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Custom Painter class to draw objects on canvas
class ObjectPainter extends CustomPainter {
  final List<Offset> objectPositions;

  ObjectPainter(this.objectPositions);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    for (var position in objectPositions) {
      canvas.drawCircle(position, 5, paint); // Draw a dot at each position
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
