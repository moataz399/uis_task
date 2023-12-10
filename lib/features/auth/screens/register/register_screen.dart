import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uis_task/core/helpers/extensions.dart';
import '../../../../core/helpers/cache_helper.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theming/styles.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/widgets/app_text_button.dart';
import '../../../../core/widgets/app_text_form_field.dart';
import '../../../home/cubits/home_cubit.dart';
import '../../cubits/register_cubit.dart';
import '../../widgets/already_have_account.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  bool isObscureText = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (BuildContext context, state) {
        if (state is RegisterSuccessState) {
          if (state.registerModel.status == true) {
            print(state.registerModel.message);
            CacheHelper.saveData(
                    key: 'token', value: state.registerModel.data!.token)
                .then((value) async {
              Constants.token = state.registerModel.data!.token!;
              await HomeCubit.get(context).getProductsData();
              await HomeCubit.get(context).getFavData();
              context.pushReplacementNamed(Routes.homeScreen);
            });
          } else {
            Fluttertoast.showToast(
                msg: state.registerModel.message!,
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
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.h),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    verticalSpace(60),
                    Text(
                      'Create Account',
                      style: TextStyles.font24BlueBold,
                    ),
                    verticalSpace(8),
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          AppTextFormField(
                              controller: nameController, hintText: 'Name'),
                          verticalSpace(18),
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
                          AppTextFormField(
                              controller: phoneController,
                              hintText: 'Phone Number'),
                          verticalSpace(18),
                          AppTextButton(
                            buttonText: "Create Account",
                            textStyle: TextStyles.font16WhiteSemiBold,
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                RegisterCubit.get(context).userRegister(
                                    email: emailController.text,
                                    name: nameController.text,
                                    phone: phoneController.text,
                                    password: passwordController.text);
                              }
                            },
                          ),
                          verticalSpace(16),
                          GestureDetector(
                              onTap: () {
                                context.pushNamed(Routes.loginScreen);
                              },
                              child: const HaveAccountText(
                                haveAccount: 'Already have an account?',
                                type: 'Login',
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
        );
      },
    );
  }
}
