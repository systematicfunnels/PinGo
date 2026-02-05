import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'dio_provider.dart';
import '../errors/app_error.dart';

part 'api_client.g.dart';

// Wrapper around Dio for API calls
class ApiClient {
  final Dio _dio;

  ApiClient(this._dio);

  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) {
    return _request(() => _dio.get(path, queryParameters: queryParameters));
  }

  Future<Response> post(String path, {dynamic data}) {
    return _request(() => _dio.post(path, data: data));
  }

  Future<Response> put(String path, {dynamic data}) {
    return _request(() => _dio.put(path, data: data));
  }

  Future<Response> delete(String path) {
    return _request(() => _dio.delete(path));
  }

  Future<Response> _request(Future<Response> Function() request) async {
    try {
      return await request();
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw UnknownError('Unexpected API error', e);
    }
  }

  AppError _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        return NetworkError('Connection failed', e, e.stackTrace);
      case DioExceptionType.badResponse:
        return NetworkError(
            'Server error: ${e.response?.statusCode}', e, e.stackTrace);
      case DioExceptionType.cancel:
        return NetworkError('Request cancelled', e, e.stackTrace);
      default:
        return UnknownError('Network error occurred', e, e.stackTrace);
    }
  }
}

@Riverpod(keepAlive: true)
ApiClient apiClient(Ref ref) {
  final dio = ref.watch(dioProvider);
  return ApiClient(dio);
}
