import 'package:flutter/material.dart';
import 'package:uis_task/core/helpers/cache_helper.dart';
import 'package:uis_task/core/helpers/extensions.dart';
import 'package:uis_task/core/theming/styles.dart';
import 'package:uis_task/core/widgets/app_text_button.dart';

import '../../../core/routing/routes.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
