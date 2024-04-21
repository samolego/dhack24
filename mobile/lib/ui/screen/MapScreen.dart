import 'package:flutter/material.dart';
import 'package:trgovinavigator/logic/tsp.dart';

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
  List<int> tspPath = [];

  @override
  void initState() {
    super.initState();
    final objPositions = widget.getObjPositions();
    findTSP(objPositions, 1, 1).then((value) {
      debugPrint("TSP path: $value");
      setState(() {
        tspPath = value;
      });
    });
  }

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
                painter:
                    ProductMarkerPainter(widget.getObjPositions(), tspPath),
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
  final List<int> tspPath;

  ProductMarkerPainter(this.objectPositions, this.tspPath);

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

    for (var i = 0; i < tspPath.length - 1; i++) {
      final start = objectPositions[tspPath[i]];
      final end = objectPositions[tspPath[i + 1]];
      final startOffset = Offset(start.dx * size.width, start.dy * size.height);
      final endOffset = Offset(end.dx * size.width, end.dy * size.height);
      canvas.drawLine(startOffset, endOffset, paint); // Draw a line between each pair of points
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
