import 'package:flutter/material.dart';
import 'package:tsp_route_finder/tsp_route_finder.dart';

Future<List<int>> findTSP(final List<FractionalOffset> objectPositions,
    double imgWidth, double imgHeight) async {
  debugPrint("I am using imgWidth: $imgWidth in imgHeight: $imgHeight");

  if (objectPositions.isEmpty) {
    return [];
  }

  var locations = [
    CitiesLocations(cityName: "Start", latitude: 0, longitude: 0)
  ];

  locations.addAll(objectPositions.map((e) => CitiesLocations(
      cityName: e.hashCode.toString(),
      latitude: e.dy * imgHeight,
      longitude: e.dx * imgWidth)));

  // Calculate the TSP route
  return TspPackage.calculateTspRoute(
          locations: locations, startingLocationIndex: 0)
      .then((value) {
    value.add(0);
    return value;
  });
}
