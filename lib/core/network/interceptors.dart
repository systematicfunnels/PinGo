import 'package:dio/dio.dart';

// Dio interceptor for auth and common headers
class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // TODO: Add auth token logic when backend is ready
    handler.next(options);
  }
}
