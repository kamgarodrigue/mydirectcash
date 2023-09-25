import 'package:dio/dio.dart';

Dio dio() {
  Dio dio = new Dio();
  dio.options.baseUrl = "http://108.181.159.14:3000/api/";
  dio.options.headers['content-Type'] = 'application/json';
  dio.options.connectTimeout = Duration(milliseconds: 3000);
  dio.options.receiveTimeout = Duration(milliseconds: 5000);
  return dio;
}//#03A9F4

