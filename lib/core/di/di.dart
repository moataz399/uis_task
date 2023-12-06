import 'package:get_it/get_it.dart';
import 'package:uis_task/features/home/cubits/home_cubit.dart';


final getIt = GetIt.instance;

Future<void> setupDI() async{


   getIt.registerFactory(() => HomeCubit());

}
