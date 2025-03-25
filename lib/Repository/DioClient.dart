import 'package:dio/dio.dart';

Dio dio() {
  Dio dio = Dio();
  dio.options.baseUrl = "http://108.181.159.14:3000/api/";// Old base URL
  dio.options.headers['content-Type'] = 'application/json';
  dio.options.connectTimeout = const Duration(milliseconds: 10000);
  dio.options.receiveTimeout = const Duration(milliseconds: 20000);
  return dio;
}//#03A9F4

