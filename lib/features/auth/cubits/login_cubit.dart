import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/helpers/dio_helper.dart';
import '../../../core/utils/end_points.dart';
import '../models/auth_model.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitialState());

  AuthModel userModel = AuthModel();

  static LoginCubit get(context) => BlocProvider.of(context);

  void userLogin({required String email, required String password}) {
    emit(LoginLoadingState());
    DioHelper.postData(url: LOGIN, data: {
      'email': email,
      'password': password,
    }).then((value) {
      print(value.data);
      userModel = AuthModel.fromJson(value.data);
      emit(LoginSuccessState(userModel));
    }).catchError((error) {
      print(error.toString());
      emit(LoginErrorState(error.toString()));
    });
  }
}
