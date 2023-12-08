import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uis_task/core/helpers/cache_helper.dart';
import 'package:uis_task/core/helpers/extensions.dart';
import 'package:uis_task/core/helpers/spacing.dart';
import 'package:uis_task/core/routing/routes.dart';
import 'package:uis_task/core/theming/styles.dart';
import 'package:uis_task/core/utils/constants.dart';
import 'package:uis_task/core/widgets/app_text_button.dart';
import 'package:uis_task/features/auth/cubits/login_cubit.dart';
import 'package:uis_task/features/home/cubits/home_cubit.dart';

import '../../../../core/widgets/app_text_form_field.dart';
import '../../widgets/already_have_account.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isObscureText = true;

  @override
  void initState() {
    super.initState();
  }

// BlocProvider.of<CharactersCubit>(context).;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (BuildContext context, state) {
        if (state is LoginSuccessState) {
          if (state.loginModel.status == true) {
            print(state.loginModel.message);

            CacheHelper.saveData(
                    key: 'token', value: state.loginModel.data!.token)
                .then((value) async {
              Constants.token = state.loginModel.data!.token!;
              await HomeCubit.get(context).getFavData();

              Future.delayed(const Duration(seconds: 2), () {
                context.pushReplacementNamed(Routes.homeScreen);
              });
              print(Constants.token);
            });
          } else {
            Fluttertoast.showToast(
                msg: state.loginModel.message!,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.TOP,
                timeInSecForIosWeb: 5,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.h),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      verticalSpace(60),
                      Text(
                        'Welcome Back',
                        style: TextStyles.font24BlueBold,
                      ),
                      verticalSpace(8),
                      Form(
                        key: formKey,
                        child: Column(
                          children: [
                            AppTextFormField(
                                controller: emailController, hintText: 'Email'),
                            verticalSpace(18),
                            AppTextFormField(
                              controller: passwordController,
                              hintText: 'Password',
                              isObscureText: isObscureText,
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isObscureText = !isObscureText;
                                  });
                                },
                                child: Icon(
                                  isObscureText
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                              ),
                            ),
                            verticalSpace(24),
                            AppTextButton(
                              buttonText: "Login",
                              textStyle: TextStyles.font16WhiteSemiBold,
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  LoginCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text);
                                }
                              },
                            ),
                            verticalSpace(16),
                            GestureDetector(
                                onTap: () {
                                  context.pushNamed(Routes.registerScreen);
                                },
                                child: const HaveAccountText(
                                  haveAccount: 'Don\'t have an account?',
                                  type: 'Register',
                                )),
                            verticalSpace(60),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
