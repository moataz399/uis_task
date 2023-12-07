

import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uis_task/core/utils/constants.dart';

class PlaceWebServices{


  late Dio dio; //declaration

  PlacesWebServices() {
    BaseOptions options = BaseOptions(
      receiveTimeout: const Duration(
        seconds: 20 * 100,
      ),
      connectTimeout: const Duration(
        seconds: 20 * 100,
      ),
      receiveDataWhenStatusError: true,
    );
    dio = Dio(options);

    //instantiation
  }

  Future<dynamic> getDirection(LatLng origin, LatLng destination) async {
    try {
      Response response = await dio.get(Constants.directionUrl, queryParameters: {
        'key': 'AIzaSyBsAyx1beWVWWB2QKW6G_-cyvZ0dcVTKBA',
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