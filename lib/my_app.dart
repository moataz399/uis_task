import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uis_task/features/auth/cubits/login_cubit.dart';
import 'package:uis_task/features/auth/cubits/register_cubit.dart';
import 'package:uis_task/features/home/cubits/home_cubit.dart';
import 'package:uis_task/features/home/cubits/search_cubit.dart';
import 'package:uis_task/features/map/cubits/map_cubit.dart';
import 'core/di/di.dart';
import 'core/helpers/cache_helper.dart';
import 'core/routing/app_router.dart';
import 'core/routing/routes.dart';
import 'core/theming/colors.dart';

class MyApp extends StatelessWidget {
  final AppRouter appRouter;

  const MyApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext context) => getIt<HomeCubit>()
              ..getFavData()
              ..getProductsData()),
        BlocProvider(create: (BuildContext context) => LoginCubit()),
        BlocProvider(create: (BuildContext context) => getIt<MapCubit>()),
        BlocProvider(create: (BuildContext context) => RegisterCubit()),
        BlocProvider(create: (BuildContext context) => SearchCubit()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        child: MaterialApp(
          theme: ThemeData(
              primaryColor: AppColors.mainBlue,
              scaffoldBackgroundColor: Colors.white),
          debugShowCheckedModeBanner: false,
          onGenerateRoute: appRouter.generateRoute,
          initialRoute: CacheHelper.getData(key: 'token') != null
              ? Routes.homeScreen
              : Routes.loginScreen,
        ),
      ),
    );
  }
}
