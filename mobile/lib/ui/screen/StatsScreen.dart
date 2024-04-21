import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:trgovinavigator/ui/component/fab_add_button.dart';

import '../../constants.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  @override
  // Random number generator
  static int timeSaved = 1 + Random().nextInt(100);
  static int usages = Random().nextInt(10);
  static final Izdelki = ["mleko","sir"];

// Generate a random time saved between 1 and 60 minutes
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Moja statistika"),
        backgroundColor: AppColors.primary,
        actions: const [
          Icon(
            Icons.shopping_cart,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  children: [
                    Text(
                      "Čas prihranjen z uporabo aplikacije:",
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "$timeSaved minut",
                      maxLines: 1,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                // number of usages of the app
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  children: [
                    Text(
                      "Število uporab aplikacije: ",
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "$usages",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            // display the graph of last 5 usages
            Container(
              padding: const EdgeInsets.all(16.0),
              height: 200,
              width: 380,
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.primary,
                  width: 0,
                ),
              ),
              child: CustomPaint(
                painter: GraphPainter(context, "Moj prihanjen čas"),
              ),
            ),
            // add fab button
            const SizedBox(
              height: 16,
            ),
          ],
        ),
      ),

      // center to the middle of the screen
      floatingActionButton: Align(
        //alignment: Alignment.bottomRight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Dodaj nov seznam'),
            const SizedBox(width: 8), // Add some spacing between text and button
            FabAddButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Dodajanj nazadnje uporabljen seznam"),
                      content: TextField(
                        decoration: const InputDecoration(
                          hintText: "Ime seznama",
                        ),
                        onChanged: (value) {
                          setState(() {
                            Izdelki.add(value);
                          });
                        },
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Prekliči"),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Dodaj"),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDayUsage(String day, int usage) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          day,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        Text(
          '$usage', // Display usage for the day
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class GraphPainter extends CustomPainter {
  final BuildContext context;
  final String title;

  GraphPainter(this.context, this.title);

  @override
  void paint(Canvas canvas, Size size, ) {
    final screenWidth = MediaQuery.of(context).size.width;
    final graphWidth = screenWidth *
        0.8; // Set the width of the graph to 80% of the screen width
    TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    final paint = Paint()
      ..color = Colors.purple
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final axisPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 1;

    final textStyle = const TextStyle(
      color: Colors.black,
      fontSize: 12,
    );

    final xLabels = [
      '14.4.',
      '16.4.',
      '18.4.',
      '20.4.',
      '22.4.',
      '24.4.',
      '26.4.',
    ];
    final yLabels = [
      '0',
      '10',
      '20',
      '30'
    ];

    final xLabelOffset = 20.0; // Offset for X-axis labels
    final yLabelOffset = 20.0; // Offset for Y-axis labels

    // Draw X-axis
    canvas.drawLine(
        Offset(0, size.height), Offset(graphWidth, size.height), axisPaint);
    for (var i = 0; i < xLabels.length; i++) {
      final x = ((i + 1) * (graphWidth / (xLabels.length + 1)));
      canvas.drawLine(
          Offset(x, size.height - 5), Offset(x, size.height + 5), axisPaint);
      TextSpan span = TextSpan(text: xLabels[i], style: textStyle);
      TextPainter tp = TextPainter(
          text: span,
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr);
      tp.layout();
      tp.paint(canvas, Offset(x - xLabelOffset, size.height + 5));
    }

    // Draw Y-axis
    canvas.drawLine(const Offset(0, 0), Offset(0, size.height), axisPaint);
    for (var i = 0; i < yLabels.length; i++) {
      final y = size.height - ((i + 1) * (size.height / (yLabels.length + 1)));
      canvas.drawLine(Offset(-5, y), Offset(5, y), axisPaint);
      TextSpan span = TextSpan(text: yLabels[i], style: textStyle);
      TextPainter tp = TextPainter(
          text: span,
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr);
      tp.layout();
      tp.paint(canvas, Offset((-yLabelOffset) as double, y - 10));
    }
    final ll = 3;
    // Draw usage data points
    final points = [
      Offset(
          1 * (graphWidth / (xLabels.length) - xLabelOffset), size.height - 20),
      // Replace these points with actual usage data points
      Offset(
          2 * (graphWidth / (xLabels.length) - xLabelOffset), size.height - 30),
      Offset(
          3 * (graphWidth / (xLabels.length) - xLabelOffset), size.height - 60),
      Offset(
          4 * (graphWidth / (xLabels.length) - xLabelOffset), size.height - 8),
      Offset(
          5 * (graphWidth / (xLabels.length) - xLabelOffset), size.height - 42),
      Offset(
          6 * (graphWidth / (xLabels.length) - xLabelOffset), size.height - 23),
      Offset(
          7 * (graphWidth / (xLabels.length) - xLabelOffset), size.height - 12),
      Offset(
          8 * (graphWidth / (xLabels.length) - xLabelOffset), size.height - 0),
      Offset(
          9 * (graphWidth / (xLabels.length) - xLabelOffset), size.height - 0),
      Offset(
          10 * (graphWidth / (xLabels.length) - xLabelOffset), size.height - 0),
      Offset(
          11* (graphWidth / (xLabels.length) - xLabelOffset), size.height - 0),
      Offset(
          12 * (graphWidth / (xLabels.length) - xLabelOffset), size.height - 12)
    ];
    canvas.drawPoints(PointMode.polygon, points, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
