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
  late List<FractionalOffset> _objPositions;

  ImageInfo? imageInfo;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    const ImageProvider imageProvider = AssetImage('assets/map.png');
    final ImageStream imageStream =
        imageProvider.resolve(createLocalImageConfiguration(context));
    imageStream.addListener(
      ImageStreamListener((ImageInfo info, bool synchronousCall) {
        setState(() {
          imageInfo = info;

          findTSP(_objPositions, imageInfo!.image.width.toDouble(),
                  imageInfo!.image.height.toDouble())
              .then((value) {
            debugPrint("TSP path: $value");
            setState(() {
              tspPath = value;
            });
          });
        });
      }),
    );
  }

  @override
  void initState() {
    super.initState();
    _objPositions = widget.getObjPositions();
  }

  @override
  Widget build(BuildContext context) {
    //final image = Image.asset('assets/map.png', height: 100, width:100);
    final image = Image.asset('assets/map.png');
    if (imageInfo == null) {
      return const Center(child: CircularProgressIndicator());
    }
    final imageSize = MediaQuery.of(context).size;
    return InteractiveViewer(
      boundaryMargin: const EdgeInsets.all(20.0),
      minScale: 0.1,
      maxScale: 5.6,
      child: Center(
        child: Stack(
          children: [
            image,
            CustomPaint(
              size: getImageSize(imageSize),
              // Use CustomPaint to draw objects on top of the image
              painter: ProductMarkerPainter(_objPositions, tspPath),
            ),
          ],
        ),
      ),
    );
  }

  //method to get image size:
  Size getImageSize(Size imageSize) {
    var w = imageInfo!.image.width.toDouble();
    var h = imageInfo!.image.height.toDouble();
    var h_rel = (imageSize.width / w) * h;
    var w_rel = imageSize.width;
    return Size(w_rel, h_rel);
  }
}

// Custom Painter class to draw objects on canvas
class ProductMarkerPainter extends CustomPainter {
  final List<FractionalOffset> objectPositions;
  final List<int> tspPath;

  ProductMarkerPainter(this.objectPositions, this.tspPath);

  @override
  void paint(Canvas canvas, Size size) {
    final paintPoint = Paint()
      ..color = Colors.orange
      ..strokeWidth = 4.0
      ..style = PaintingStyle.stroke;

    final paintBorder = Paint()
      ..color = Colors.black
      ..strokeWidth = 6.0
      ..style = PaintingStyle.stroke;

    final paintLine = Paint()
      ..color = Colors.yellow
      ..strokeWidth = 4.0
      ..style = PaintingStyle.stroke;

    for (var i = 0; i < tspPath.length - 1; i++) {
      final start = objectPositions[tspPath[i]];
      final end = objectPositions[tspPath[i + 1]];
      final startOffset = Offset(start.dx * size.width, start.dy * size.height);
      final endOffset = Offset(end.dx * size.width, end.dy * size.height);
      canvas.drawLine(startOffset, endOffset, paintBorder);
      canvas.drawLine(startOffset, endOffset, paintLine); // Draw a line between each pair of points
    }

    for (var position in objectPositions) {
      final offset =
      Offset(position.dx * size.width, position.dy * size.height);
      canvas.drawCircle(offset, 5, paintBorder); // Draw a dot at each positionp
      canvas.drawCircle(offset, 5, paintPoint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
