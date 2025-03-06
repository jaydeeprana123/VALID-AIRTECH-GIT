import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'error_interceptor.dart';

class API {
  static API? _dioClient;
  static late Dio _dio;

  factory API() {
    _dioClient ??= API._internal();
    return _dioClient!;
  }

  API._internal() {
    _dio = Dio(
      BaseOptions(
          baseUrl: 'https://validairtech.avds.pw/api/admin',
          connectTimeout: const Duration(seconds: 60),
          receiveTimeout: const Duration(seconds: 60)),
    );
    _dio.interceptors.add(PrettyDioLogger(request: true,requestBody: true,requestHeader: true));
    _dio.interceptors.add(ErrorInterceptor());
  }

  Dio get dio => _dio;

  void dispose() {
    _dio.close();
  }
}