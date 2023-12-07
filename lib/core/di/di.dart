import 'package:get_it/get_it.dart';
import 'package:uis_task/core/helpers/cache_helper.dart';
import 'package:uis_task/features/home/cubits/home_cubit.dart';
import 'package:uis_task/features/map/cubits/map_cubit.dart';
import 'package:uis_task/features/map/data/web_services/place_web_service.dart';
import 'package:uis_task/features/map/data/repo/map_repo.dart';


final getIt = GetIt.instance;

Future<void> setupDI() async{


   getIt.registerFactory(() => HomeCubit());
   getIt.registerFactory(() => CacheHelper());


   getIt.registerFactory(() => MapCubit(getIt<MapsRepository>()));

   getIt.registerFactory(() => MapsRepository(getIt<PlaceWebServices>()));

   getIt.registerFactory(() => PlaceWebServices());
}
