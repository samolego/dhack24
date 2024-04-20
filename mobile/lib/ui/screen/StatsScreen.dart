import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:math';

import '../../constants.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  @override
  // Random number generator
  final Random random = Random();
// Generate a random time saved between 1 and 60 minutes
  Widget build(BuildContext context) {
    int timeSaved = 1 + random.nextInt(30);
    return Stack(
      children: [
        Positioned(
          bottom: 0,
          top: 0,
          right: 0,
          left: 0,
          child: Column(
            children: [
              Container(
                // Add color to the container
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          "Moja Statistika",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                    // display an icon of a shopping cart
                    Column(
                      children: [
                        const Icon(
                          Icons.shopping_cart,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          top: 50,
          right: 0,
          left: 0,
          child: Column(
            children: [

              Container(
                padding: const EdgeInsets.all(8.0),
                // centre to the left
                child: Column(
                  children: [
                    Text(
                      "Čas prihranjen z uporabo aplikacije:",
                    ),
                    Text(
                      "$timeSaved minut",
                      maxLines: 1,
                    ),
                    // number of usages of the app
                    Text(
                      "Število uporab aplikacije: ",
                    ),
                    Text(
                      "${random.nextInt(10)}",
                      maxLines: 1,
                    ),
                    // display the graph of last 5 usages
                    Container(
                      height: 200,
                      width: 380,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.primary,
                          width: 0,
                        ),
                      ),
                      child: CustomPaint(
                        painter: GraphPainter(context),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
  Widget _buildDayUsage(String day, int usage) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          day,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 5),
        Text(
          '$usage', // Display usage for the day
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
class GraphPainter extends CustomPainter {
  final BuildContext context;
  GraphPainter(this.context);
  @override
  void paint(Canvas canvas, Size size) {
    final screenWidth = MediaQuery.of(context).size.width;
    final graphWidth = screenWidth * 0.8; // Set the width of the graph to 80% of the screen width

    final paint = Paint()
      ..color = Colors.purple
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final axisPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 1;

    final textStyle = TextStyle(
      color: Colors.black,
      fontSize: 12,
    );

    final xLabels = ['Day 1', 'Day 2', 'Day 3',"Day 4"]; // Replace with actual labels for the X-axis
    final yLabels = ['0', '10', '20', '30']; // Replace with actual labels for the Y-axis

    final xLabelOffset = 20.0; // Offset for X-axis labels
    final yLabelOffset = 20.0; // Offset for Y-axis labels

    // Draw X-axis
    canvas.drawLine(Offset(0, size.height), Offset(graphWidth, size.height), axisPaint);
    for (var i = 0; i < xLabels.length; i++) {
      final x = ((i + 1) * (graphWidth / (xLabels.length + 1)));
      canvas.drawLine(Offset(x, size.height - 5), Offset(x, size.height + 5), axisPaint);
      TextSpan span = TextSpan(text: xLabels[i], style: textStyle);
      TextPainter tp = TextPainter(text: span, textAlign: TextAlign.center, textDirection: TextDirection.ltr);
      tp.layout();
      tp.paint(canvas, Offset(x - xLabelOffset, size.height + 5));
    }

    // Draw Y-axis
    canvas.drawLine(Offset(0, 0), Offset(0, size.height), axisPaint);
    for (var i = 0; i < yLabels.length; i++) {
      final y = size.height - ((i + 1) * (size.height / (yLabels.length + 1)));
      canvas.drawLine(Offset(-5, y), Offset(5, y), axisPaint);
      TextSpan span = TextSpan(text: yLabels[i], style: textStyle);
      TextPainter tp = TextPainter(text: span, textAlign: TextAlign.center, textDirection: TextDirection.ltr);
      tp.layout();
      tp.paint(canvas, Offset((-yLabelOffset) as double, y - 10));
    }
    final ll = 3;
    // Draw usage data points
    final points = [
      Offset(1 * (graphWidth / (xLabels.length) - xLabelOffset), size.height - 20), // Replace these points with actual usage data points
      Offset(2 * (graphWidth / (xLabels.length) - xLabelOffset), size.height - 30),
      Offset(3 * (graphWidth / (xLabels.length) - xLabelOffset), size.height - 60),
      Offset(4 * (graphWidth / (xLabels.length) - xLabelOffset), size.height - 8)
    ];
    canvas.drawPoints(PointMode.polygon, points, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
