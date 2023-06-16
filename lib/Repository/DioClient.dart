import 'package:dio/dio.dart';

Dio dio() {
  Dio dio = new Dio();
  dio.options.baseUrl = "http://172.107.60.78:3000/api/";
  dio.options.headers['content-Type'] = 'application/json';
  dio.options.connectTimeout = 3000;
  dio.options.receiveTimeout = 5000;
  return dio;
}//#03A9F4

