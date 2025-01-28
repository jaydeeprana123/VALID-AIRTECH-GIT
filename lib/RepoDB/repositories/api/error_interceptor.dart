import "dart:typed_data";

import "package:dio/dio.dart";

import "interceptor_error_response.dart";


class ErrorInterceptor extends Interceptor {
  static int? getStatusCode;

  ErrorInterceptor();

  ErrorInterceptor.fromTest();

  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    var errorResponse = {};

    if (err.response?.statusCode == 401) {

    }

    if (err.type == DioExceptionType.receiveTimeout) {
      getStatusCode = 408;
    } else {
      getStatusCode = err.response?.statusCode;
    }
    var response = err.response;

    if (errorResponse.isNotEmpty) {
      response?.data = errorResponse;
    }

    if (response == null || response.data is Uint8List) {
      handler.resolve(Response(
        requestOptions: RequestOptions(),
        data: ErrorInterceptorConstants.kInterceptorError,
      ));
    } else if ((response.data as Map).isEmpty) {
      handler.resolve(Response(
        requestOptions: RequestOptions(),
        data: ErrorInterceptorConstants.kInterceptorError,
      ));
    } else {
      handler.resolve(response);
    }
  }
}
