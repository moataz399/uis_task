import 'package:flutter/material.dart';
import 'package:uis_task/core/helpers/extensions.dart';

import '../../../core/helpers/cache_helper.dart';
import '../../../core/routing/routes.dart';
import '../../../core/theming/styles.dart';
import '../../../core/widgets/app_text_button.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
        child: AppTextButton(
          buttonText: "logout",
          onPressed: () {
            CacheHelper.removeData(key: 'token');
            context.pushReplacementNamed(Routes.loginScreen);
          },
          textStyle: TextStyles.font24BlackBold,
        ),
      ),
    );
  }
}
