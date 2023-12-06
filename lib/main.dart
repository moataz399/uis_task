import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'core/di/di.dart';
import 'core/helpers/bloc_observer.dart';
import 'core/helpers/cache_helper.dart';
import 'core/helpers/dio_helper.dart';
import 'core/routing/app_router.dart';
import 'my_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDI();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.cacheInit();
  await DioHelper.init();
  runApp(MyApp(appRouter: AppRouter()));
}
