import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uis_task/core/helpers/dio_helper.dart';
import 'package:uis_task/core/utils/constants.dart';

class PlaceWebServices {
  PlacesWebServices() {}

  Future<dynamic> getDirection(LatLng origin, LatLng destination) async {
    try {
      Response response =
          await DioHelper.getData(url: Constants.directionUrl, query: {
        'key': Constants.taskMapApiKey,
        'origin': '${origin.latitude},${origin.longitude}',
        'destination': '${destination.latitude},${destination.longitude}',
      });

      return response.data;
    } catch (error) {
      print(error.toString());
      return Future.error('Place Location error : ',
          StackTrace.fromString('this is its trace'));
    }
  }
}
