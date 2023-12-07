import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uis_task/core/routing/routes.dart';
import 'package:uis_task/features/home/screens/product_details.dart';
import 'package:uis_task/features/home/screens/product_screen.dart';
import 'package:uis_task/features/home/screens/search_screen.dart';
import 'package:uis_task/features/map/screens/map_screen.dart';

import '../../features/auth/cubits/login_cubit.dart';
import '../../features/auth/cubits/register_cubit.dart';
import '../../features/auth/screens/login/login_screen.dart';
import '../../features/auth/screens/register/register_screen.dart';
import '../../features/home/home_screen.dart';

class AppRouter {
  AppRouter();

  Route? generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;

    switch (settings.name) {
      case Routes.homeScreen:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );



      case Routes.mapScreen:
        return MaterialPageRoute(
          builder: (_) =>  MapScreen(),
        );

      case Routes.productsScreen:
        return MaterialPageRoute(
          builder: (_) => const ProductsScreen(),
        );

      case Routes.searchScreen:
        return MaterialPageRoute(
          builder: (_) => const SearchScreen(),
        );
      case Routes.productDetailsScreen:
        return MaterialPageRoute(
          builder: (_) => const ProductDetailsScreen(),
        );

      case Routes.loginScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
              create: (context) => LoginCubit(), child: const LoginScreen()),
        );
      case Routes.registerScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => RegisterCubit(),
            child: const RegisterScreen(),
          ),
        );
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('NO route defined to ${settings.name}'),
                  ),
                ));
    }
  }
}
