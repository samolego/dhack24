import 'package:flutter/material.dart';

class MapScreen extends StatefulWidget {
  final List<FractionalOffset> Function() getObjPositions;

  const MapScreen({
    super.key,
    required this.getObjPositions,
  });

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    final image = Image.asset('assets/map.png');
    final imageSize = MediaQuery.of(context).size;
    return InteractiveViewer(
      boundaryMargin: const EdgeInsets.all(20.0),
      minScale: 0.1,
      maxScale: 5.6,
      child: Center(
        child: SizedBox(
          width: imageSize.width,
          height: imageSize.height,
          child: Stack(
            children: [
              image,
              CustomPaint(
                // Use CustomPaint to draw objects on top of the image
                painter: ProductMarkerPainter(widget.getObjPositions()),
              ),
            ],
          ),
        ),
      ),
    );
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
