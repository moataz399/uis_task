import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/helpers/dio_helper.dart';
import '../../../core/utils/end_points.dart';
import '../models/auth_model.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitialState());


  AuthModel userModel = AuthModel();

  static RegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({required String email, required String password,required String name,required String phone}) {
    emit(RegisterLoadingState());
    DioHelper.postData(url: REGISTER, data: {
      'email': email,
      'password': password,
      "name": name,
      "phone": phone
    }).then((value) {
      print(value.data);
      userModel = AuthModel.fromJson(value.data);
      print(userModel.data);
      emit(RegisterSuccessState(userModel));
    }).catchError((error) {
      print(error.toString());
      emit(RegisterErrorState(error.toString()));
    });
  }
}