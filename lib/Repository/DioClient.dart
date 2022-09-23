import 'package:dio/dio.dart';

Dio dio() {
  Dio dio = new Dio();
  dio.options.baseUrl = "http://46.182.6.200:3000/api/";
  dio.options.headers['content-Type'] = 'application/json';
  return dio;
}//#03A9F4

