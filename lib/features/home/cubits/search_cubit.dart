import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:uis_task/core/helpers/cache_helper.dart';
import 'package:uis_task/core/helpers/dio_helper.dart';
import 'package:uis_task/features/home/data/models/search_model.dart';

import '../../../core/utils/end_points.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? searchModel;

  void search(String text) {
    emit(SearchLoadingState());

    DioHelper.postData(
        token: CacheHelper.getData(key: 'token'),
        url: SEARCH,
        data: {
          'text': text,
        }).then((value) {



      searchModel = SearchModel.fromJson(value.data);
      emit(SearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SearchErrorState());
    });
  }
}

