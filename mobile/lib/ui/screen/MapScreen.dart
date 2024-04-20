import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: const MapOptions(
        initialCenter: LatLng(0, 0),
        initialZoom: 0,
      ),
      children: [
        TileLayer(
          tileProvider: AssetTileProvider(),
          urlTemplate: 'assets/offlineMap/{z}/{x}/{y}.png',
        ),
        RichAttributionWidget(
          attributions: [
            TextSourceAttribution(
              'OpenStreetMap contributors',
              onTap: () => print('OpenStreetMap contributors'),
            ),
          ],
        ),
      ],
    );
  }
}
