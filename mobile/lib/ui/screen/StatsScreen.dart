import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:trgovinavigator/ui/component/uporabi_button.dart';

import '../../constants.dart';

class StatsScreen extends StatefulWidget {
  final VoidCallback onUse;

  const StatsScreen({super.key, required this.onUse});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  // Random number generator
  static int timeSaved = 1 + Random().nextInt(100);
  static int usages = Random().nextInt(10);

  @override
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
      floatingActionButton: UporabiButton(
        text: "zadnji seznam",
        onUse: () {
          widget.onUse();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Card(
              borderOnForeground: true,
              surfaceTintColor: Colors.white,
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Column(
                          children: [
                            Text(
                              "Čas, prihranjen z uporabo aplikacije:",
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "$timeSaved minut",
                              maxLines: 1,
                              style: const TextStyle(
                                fontSize: 16,
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
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(
              height: 16,
            ),
            const SizedBox(
              width: 256,
              child: Divider(
                color: Colors.grey,
                thickness: 2,
              ),
            ),
            const SizedBox(
              height: 16,
            ),

            Text(
              "Prihranjene minute",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            // display the graph of last 5 usages
            Container(
              padding: const EdgeInsets.all(16.0),
              height: 200,
              width: 380,
              child: CustomPaint(
                painter: GraphPainter(context, ""),
              ),
            ),
            // add fab button
            const SizedBox(
              height: 64,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    "Zadnji nakupovalni seznam",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Card(
                    borderOnForeground: true,
                    surfaceTintColor: Colors.white,
                    elevation: 4,
                    child: InkWell(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SingleChildScrollView(
                          physics: const NeverScrollableScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                lastShoppingListName,
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                // Show first 3 items
                                "${lastShoppingList.map((e) => e.ime_izdelka).take(3).join("\n")}${lastShoppingList.length > 3 ? "\n..." : ''}",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
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
  void paint(
    Canvas canvas,
    Size size,
  ) {
    final screenWidth = MediaQuery.of(context).size.width;
    final graphWidth = screenWidth *
        0.8; // Set the width of the graph to 80% of the screen width
    TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: title,
        style: const TextStyle(
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
    final yLabels = ['0', '10', '20', '30'];

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
          11 * (graphWidth / (xLabels.length) - xLabelOffset), size.height - 0),
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
