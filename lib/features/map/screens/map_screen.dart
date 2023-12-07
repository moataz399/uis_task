import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uis_task/core/helpers/location_helper.dart';
import 'package:uis_task/core/theming/colors.dart';
import 'package:uis_task/features/map/cubits/map_cubit.dart';

import '../../../core/utils/constants.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  initState() {
    super.initState();
    getCurrentLocation();
    _addMarker(LatLng(destLatitude, destLongitude), "destination",
        BitmapDescriptor.defaultMarkerWithHue(90));
    _getPolyline();
  }

  static Position? position;
  Completer<GoogleMapController> mapController = Completer();
  static final CameraPosition _myCurrentLocationCameraPosition = CameraPosition(
      bearing: 0.0,
      target: LatLng(position!.latitude, position!.longitude),
      zoom: 17,
      tilt: 0.0);
  double destLatitude = 31.444797667923186, destLongitude = 31.665512167004664;

  Map<MarkerId, Marker> markers = {};
  Map<PolylineId, Polyline> polyLines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();

  _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
    MarkerId markerId = MarkerId(id);
    Marker marker =
        Marker(markerId: markerId, icon: descriptor, position: position);
    markers[markerId] = marker;
  }

  _getPolyline() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        Constants.taskMapApiKey,
        PointLatLng(position!.latitude, position!.longitude),
        PointLatLng(destLatitude, destLongitude),
        travelMode: TravelMode.driving,
        wayPoints: [PolylineWayPoint(location: "New Damietta")]);
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    _addPolyLine();
  }

  _addPolyLine() {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id, color: Colors.red, points: polylineCoordinates);
    polyLines[id] = polyline;
    setState(() {});
  }

  Future<void> getCurrentLocation() async {
    position = await LocationHelper.getCurrentLocation().whenComplete(() {
      setState(() {});
    });
  }

  Future<void> _goToMYCurrentLocation() async {
    final GoogleMapController controller = await mapController.future;
    controller.animateCamera(
        CameraUpdate.newCameraPosition(_myCurrentLocationCameraPosition));
    _getPolyline();
  }

  Widget buildMap() {
    return GoogleMap(
      initialCameraPosition: _myCurrentLocationCameraPosition,
      myLocationEnabled: true,
      zoomControlsEnabled: false,
      myLocationButtonEnabled: false,
      onMapCreated: (GoogleMapController googleMapController) {
        mapController.complete(googleMapController);
      },
      markers: Set<Marker>.of(markers.values),
      polylines: Set<Polyline>.of(polyLines.values),
      mapType: MapType.normal,
    );
  }

  @override
  Widget build(BuildContext context) {
    var cubit = MapCubit.get(context);
    return BlocBuilder<MapCubit, MapState>(
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              position != null
                  ? buildMap()
                  : const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.mainBlue,
                      ),
                    ),
            ],
          ),
          floatingActionButton: Container(
            margin: EdgeInsets.fromLTRB(0, 0, 8.w, 30.h),
            child: FloatingActionButton(
              backgroundColor: AppColors.mainBlue,
              onPressed: _goToMYCurrentLocation,
              child: const Icon(
                Icons.place,
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }
}
