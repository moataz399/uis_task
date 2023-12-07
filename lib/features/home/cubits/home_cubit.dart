import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uis_task/core/helpers/dio_helper.dart';
import 'package:uis_task/core/utils/constants.dart';
import 'package:uis_task/features/home/data/models/product_model.dart';

import '../../../core/helpers/cache_helper.dart';
import '../../../core/utils/end_points.dart';
import '../data/models/change_fav_model.dart';
import '../data/models/fav_model.dart';
import '../data/models/product_details.dart';
import '../screens/fav_screen.dart';
import '../screens/product_screen.dart';
import '../screens/settings_screen.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);

  ProductModel? productsModel;
  ChangeFavoritesModel? changeFavoritesModel;

  FavModel? favModel;
  Map<int, bool> fav = {};

  List<Widget> screen = [
    const ProductsScreen(),
    const FavoritesScreen(),
    const SettingsScreen(),
  ];

  int currentIndex = 0;

  List<String> titles = [
    'Home',
    'Favorites',
    'Settings',
  ];

  void changeIndex(int index) {
    currentIndex = index;

    emit(ChangeBottomNav());
  }

  Future<void> getProductsData() async {
    emit(HomeLoadingState());

    await DioHelper.getData(url: HOME, token: Constants.token).then((value) {
      productsModel = ProductModel.fromJson(value.data);

      for (var element in productsModel!.data!.products!) {
        fav.addAll({
          element.id!: element.inFavorites!,
        });
      }

      emit(HomeSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(HomeErrorState(error.toString()));
    });
  }

  void changeFav(int id) {
    fav[id] = !fav[id]!;
    emit(FavoritesChangeSuccess());

    DioHelper.postData(
      url: FAVORITES,
      data: {
        'product_id': id,
      },
      token: CacheHelper.getData(key: 'token'),
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      if (!changeFavoritesModel!.status!) {
        fav[id] = !fav[id]!;
      } else {
        getFavData();
      }

      emit(FavoritesSuccess(changeFavoritesModel!));
    }).catchError((error) {
      emit(FavoritesChangeError(error));
    });
  }

  Future<void> getFavData() async {
    emit(GetFavoritesLoading());

    await DioHelper.getData(
      url: FAVORITES,
      token: CacheHelper.getData(key: 'token'),
    ).then((value) {
      favModel = FavModel.fromJson(value.data);
      print(CacheHelper.getData(key: 'token'));

      emit(GetFavoritesSuccess());
    }).catchError((error) {
      emit(GetFavoritesError(error));
    });
  }

  ProductDetails? productDetails;

  Future<void> getProductDetails({required int id}) async {
    emit(GetProductDetailsLoading());

    await DioHelper.getData(
      url: 'products/$id',
      token: CacheHelper.getData(key: 'token'),
    ).then((value) {
      productDetails = ProductDetails.fromJson(value.data);
      print(value.data);
      print(CacheHelper.getData(key: 'token'));

      emit(GetProductDetailsSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(GetProductDetailsError(error));
    });
  }
}
