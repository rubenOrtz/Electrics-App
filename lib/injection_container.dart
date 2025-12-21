import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  
  // Dio
  sl.registerSingleton<Dio>(Dio());

  // Dependencies
  // Here we would register data sources, repositories, use cases, and blocs.
  
}
