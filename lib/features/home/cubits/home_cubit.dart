import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:uis_task/core/helpers/dio_helper.dart';
import 'package:uis_task/core/utils/constants.dart';
import 'package:uis_task/features/home/data/models/product_model.dart';

import '../../../core/utils/end_points.dart';
import '../data/models/change_fav_model.dart';
import '../screens/fav_screen.dart';
import '../screens/product_screen.dart';
import '../screens/settings_screen.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);

  ProductModel? productsModel;
  ChangeFavoritesModel? changeFavoritesModel;
  Map<int, bool> fav = {};

  List<Widget> screen =  [
    ProductsScreen(),
    FavoritesScreen(),
    SettingsScreen(),
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

  void getProductsData() async {
    emit(HomeLoadingState());

    await DioHelper.getData(url: HOME, token: Constants.token).then((value) {
      productsModel = ProductModel.fromJson(value.data);

      productsModel!.data!.products!.forEach((element) {
        fav.addAll({
          element.id!: element.inFavorites!,
        });
      });
      print(fav.toString());

      emit(HomeSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(HomeErrorState(error.toString()));
    });
  }

  void changeFav(int id) {


    fav[id]=!fav[id]!;
    emit(FavoritesChangeSuccess());


    DioHelper.postData(
      url: FAVORITES,
      data: {
        'product_id': id,
      },
      token: Constants.token ,
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      print(value.data);
      print(Constants.token);

      if(!changeFavoritesModel!.status!){
        fav[id]=!fav[id]!;

      }

      emit(FavoritesSuccess(changeFavoritesModel!));
    }).catchError((error) {
      emit(FavoritesChangeError(error));
    });
  }
}
