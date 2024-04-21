import 'package:flutter/material.dart';
import 'package:tsp_route_finder/tsp_route_finder.dart';

Future<List<int>> findTSP(final List<FractionalOffset> objectPositions,
    double imgWidth, double imgHeight) async {
  debugPrint("Not using imgWidth: $imgWidth in imgHeight: $imgHeight!!");

  // Define a list locations
  final List<CitiesLocations> locations = objectPositions
      .map((e) => CitiesLocations(
          cityName: e.hashCode.toString(),
          latitude: e.dy, // * imgHeight,
          longitude: e.dx // * imgWidth
          ))
      .toList();

  // Calculate the TSP route
  return TspPackage.calculateTspRoute(
      locations: locations, startingLocationIndex: 0);
}
