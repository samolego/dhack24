import 'package:flutter/material.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  // List to hold the positions of drawn objects
  List<Offset> objectPositions = const [Offset(0, 0), Offset(100, 100), Offset(50, 50), Offset(150, 150), Offset(200, 200)];
  
  @override
  Widget build(BuildContext context) {
    final image = Image.asset('assets/map.png');
    return InteractiveViewer(
      boundaryMargin: const EdgeInsets.all(20.0),
      minScale: 0.1,
      maxScale: 5.6,
      child: Center(
        child: Stack(
        children: [
          image,
          Container(
          width: 100, // Set the width you want
          height: 100, // Set the height you want
          child: GestureDetector(
            onTapUp: (details) {
              setState(() {
                // Add the position where user tapped
                var point = details.localPosition;
                objectPositions.add(point);
                debugPrint("$point");
              });
            },
          )
          ),
          CustomPaint(
            // Use CustomPaint to draw objects on top of the image
            painter: ObjectPainter(objectPositions),
          ),
        ],
      ),
    )
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
