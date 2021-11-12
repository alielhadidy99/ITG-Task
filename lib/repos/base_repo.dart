import 'package:get_it/get_it.dart';
import 'package:itg_marvel_task/utils/dio_utils.dart';

class BaseRepository {
  DioUtils dio = GetIt.instance<DioUtils>();
}
