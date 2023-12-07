import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uis_task/core/helpers/location_helper.dart';
import 'package:uis_task/core/theming/colors.dart';

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
  }


  static Position? position;

  Completer<GoogleMapController> _mapController = Completer();
  static final CameraPosition _myCurrentLocationCameraPosition = CameraPosition(
      bearing: 0.0,
      target: LatLng(position!.latitude, position!.longitude),
      zoom: 17,
      tilt: 0.0);

  Future<void> getCurrentLocation() async {
    position= await LocationHelper.getCurrentLocation().whenComplete(() {
          setState(() {});
    });


  }

  Widget buildMap() {
    return GoogleMap(
      initialCameraPosition: _myCurrentLocationCameraPosition,
      myLocationEnabled: true,
      zoomControlsEnabled: false,
      myLocationButtonEnabled: false,
      onMapCreated: (GoogleMapController googleMapController) {
        _mapController.complete(googleMapController);
      },
      markers: {
        Marker(
          markerId: const MarkerId('1'),
          position:  LatLng(31.444797667923186, 31.665512167004664),
        )
      },
      mapType: MapType.normal,
    );
  }
  Future<void>_goToMYCurrentLocation ()async{
    final GoogleMapController controller=await _mapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_myCurrentLocationCameraPosition));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          position != null
              ? buildMap()
              : const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.mainBlue,
                  ),
                )
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
  }
}
