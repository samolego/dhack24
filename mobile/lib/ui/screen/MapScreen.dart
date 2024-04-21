import 'package:flutter/material.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();

  void updateObjectPositions(List<FractionalOffset> newPositions) {
    (_MapScreenState state) => state._updateObjectPositions(newPositions);
  }
}

class _MapScreenState extends State<MapScreen> {
  // List to hold the positions of drawn objects
  List<FractionalOffset> _objectPositions = const [
    FractionalOffset(0.0, 0.0),
    FractionalOffset(0.5, 0.5),
    FractionalOffset(0.25, 0.25),
    FractionalOffset(0.75, 0.75),
    FractionalOffset(1.0, 1.0),
  ];

  void _updateObjectPositions(List<FractionalOffset> newPositions) {
    setState(() {
      _objectPositions = newPositions;
    });
  }

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
              /*Container(
          width: 100, // Set the width you want
          height: 100, // Set the height you want
          child: GestureDetector(
            onTapUp: (details) {
              setState(() {
                // Add the position where user tapped
                var point = details.localPosition;
                _objectPositions.add(point);
                debugPrint("$point");
              });
            },
          )
          ),*/
              CustomPaint(
                // Use CustomPaint to draw objects on top of the image
                painter: ProductMarkerPainter(_objectPositions),
              ),
            ],
          ),
        ));
  }
}

// Custom Painter class to draw objects on canvas
class ProductMarkerPainter extends CustomPainter {
  final List<FractionalOffset> objectPositions;

  ProductMarkerPainter(this.objectPositions);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    for (var position in objectPositions) {
      final offset =
          Offset(position.dx * size.width, position.dy * size.height);
      canvas.drawCircle(offset, 5, paint); // Draw a dot at each positionp
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
