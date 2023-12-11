import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

final getIt = GetIt.instance;

Future<void> setUp() async {
  final dio =
      Dio(BaseOptions(baseUrl: "https://jsonplaceholder.typicode.com/"));
  dio.interceptors.addAll([
    PrettyDioLogger(requestBody: true),
  ]);
  getIt.registerSingleton(dio);
}

