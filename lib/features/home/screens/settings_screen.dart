import 'package:flutter/material.dart';
import 'package:uis_task/core/helpers/extensions.dart';

import '../../../core/helpers/cache_helper.dart';
import '../../../core/routing/routes.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: TextButton(onPressed: () async {
            await CacheHelper.removeData(key: 'token');
            context.pushReplacementNamed(Routes.loginScreen);
          }, child: const Text('logout ')),
        )
    );
  }
}
