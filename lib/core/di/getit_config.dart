import 'package:get_it/get_it.dart';
import '/core/repositories/log/log.dart';
import '/core/repositories/log/log_impl.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies() async {
  getIt.registerFactory<Log>(() => LogImpl());
  // getIt.registerFactory<AuthController>(() => AuthController());
}
