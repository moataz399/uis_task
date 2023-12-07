part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class ChangeBottomNav extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeSuccessState extends HomeState {}

class HomeErrorState extends HomeState {
  final error;

  HomeErrorState(this.error);
}

class FavoritesChangeSuccess extends HomeState {}

class FavoritesSuccess extends HomeState {
  final ChangeFavoritesModel model;

  FavoritesSuccess(this.model);
}

class FavoritesChangeError extends HomeState {
  final error;

  FavoritesChangeError(this.error);
}

class GetFavoritesLoading extends HomeState {}

class GetFavoritesSuccess extends HomeState {}

class GetFavoritesError extends HomeState {
  final error;

  GetFavoritesError(this.error);
}







class GetProductDetailsLoading extends HomeState {}

class GetProductDetailsSuccess extends HomeState {}

class GetProductDetailsError extends HomeState {
  final error;

  GetProductDetailsError(this.error);
}