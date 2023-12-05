import 'package:flutter/material.dart';
import 'package:uis_task/core/helpers/extensions.dart';

import '../../core/helpers/cache_helper.dart';
import '../../core/routing/routes.dart';
import '../../core/theming/styles.dart';
import '../../core/widgets/app_text_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: AppTextButton(
        onPressed: () {
          CacheHelper.removeData(key: 'token').then((value) {
            if (value) {
              context.pushNamed(Routes.loginScreen);
            }
          });
        },
        buttonText: "logout",
        backgroundColor: Colors.deepPurpleAccent,
        textStyle: TextStyles.font16WhiteSemiBold,
      )),
    );
  }
}
