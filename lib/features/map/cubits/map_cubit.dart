import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';
import 'package:uis_task/features/map/data/repo/map_repo.dart';

import '../data/models/directions_model.dart';

part 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  final MapsRepository mapsRepository;

  MapCubit(this.mapsRepository) : super(MapInitial());
  static MapCubit get(context) => BlocProvider.of(context);
  void emitPlaceDirections(LatLng origin, LatLng destination) async {
    mapsRepository.getDirections(origin, destination).then(
      (directions) {
        emit(PlaceDirectionsLoaded(directions));
      },
    );
  }
}
