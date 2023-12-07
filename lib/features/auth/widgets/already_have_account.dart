



import 'package:flutter/material.dart';

import '../../../../core/theming/styles.dart';

class HaveAccountText extends StatelessWidget {

  const HaveAccountText({super.key, required this.haveAccount,required this.type });

  final String type ;

  final String haveAccount;

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: haveAccount,
            style: TextStyles.font13DarkBlueRegular,
          ),
          TextSpan(
            text: type,
            style: TextStyles.font13BlueSemiBold,
          ),
        ],
      ),
    );
  }

}