import 'package:flutter/material.dart';
import 'package:uis_task/core/theming/styles.dart';
import 'package:uis_task/core/widgets/app_text_button.dart';
import 'package:uis_task/features/home/cubits/home_cubit.dart';
import '../../../core/helpers/cache_helper.dart';
import '../../../core/helpers/extensions.dart';
import '../../auth/screens/login/login_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.blue, borderRadius: BorderRadius.circular(24)),
          width: 150,
          height: 70,
          child: TextButton(
            onPressed: () {
              CacheHelper.removeData(key: 'token');
              HomeCubit.get(context).currentIndex=0;
              navigateAndFinish(context, const LoginScreen());
            },
            child: const Text(
              'Log out ',
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
