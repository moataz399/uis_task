part of 'map_cubit.dart';

@immutable
abstract class MapState {}

class MapInitial extends MapState {}
class PlaceDirectionsLoaded extends MapState {
  final  PlaceDirections directions;

  PlaceDirectionsLoaded( this.directions);
}