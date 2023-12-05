import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'core/helpers/bloc_observer.dart';
import 'core/helpers/cache_helper.dart';
import 'core/helpers/dio_helper.dart';
import 'core/routing/app_router.dart';
import 'core/utils/constants.dart';
import 'my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.cacheInit();
  await DioHelper.init();
   //Constants.token = CacheHelper.getData(key: 'token');
  runApp(MyApp(appRouter: AppRouter()));
}
