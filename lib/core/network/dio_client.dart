import 'package:dio/dio.dart';

class ApiConstants {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';
  static const String postsEndpoint = '/posts';
  static const int connectTimeoutMs = 30000;
  static const int receiveTimeoutMs = 30000;
}

class DioClient {
  late final Dio dio;

  DioClient() {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(
          milliseconds: ApiConstants.connectTimeoutMs,
        ),
        receiveTimeout: const Duration(
          milliseconds: ApiConstants.receiveTimeoutMs,
        ),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        requestHeader: false,
        responseHeader: false,
      ),
    );
  }
}
