import 'package:flutter/material.dart';
import 'package:uis_task/features/auth/login/login_screen.dart';
import 'package:uis_task/features/home/cubits/home_cubit.dart';

import '../../../core/helpers/cache_helper.dart';
import '../../../core/routing/routes.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: TextButton(
          onPressed: () async {
            await CacheHelper.removeData(key: 'token');
            HomeCubit.get(context).fav.clear();

            // HomeCubit.get(context).favModel=FavModel();



            navigateAndFinish(context, LoginScreen());
          },
          child: const Text('logout ')),
    ));
  }
}
