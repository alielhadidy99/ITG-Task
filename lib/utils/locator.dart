import 'package:get_it/get_it.dart';
import 'package:itg_marvel_task/repos/characters_repository.dart';
import 'dio_utils.dart';

GetIt locator = GetIt.I;
//Singleton
setup() async {
  locator.allowReassignment = true;
  locator.registerSingleton<DioUtils>(DioUtils.getInstance());
  locator.registerSingleton<CharactersRepository>(
      CharactersRepository.getInstance());
}
