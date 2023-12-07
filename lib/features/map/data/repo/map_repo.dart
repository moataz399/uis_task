import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/directions_model.dart';
import '../web_services/place_web_service.dart';

class MapsRepository {
  final PlaceWebServices placesWebServices;

  MapsRepository(this.placesWebServices);

  Future<dynamic> getDirections(LatLng origin, LatLng destination) async {
    final directions =
        await placesWebServices.getDirection(origin, destination);

    return PlaceDirections.fromJson(directions);
  }
}
