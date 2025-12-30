import 'package:dio/dio.dart';
import 'package:new_apta_grading/core/utils/local_storage.dart';

class AuthorizationInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await getStringStorage(StorageKey.accessToken);
    options.headers['Authorization'] = 'Bearer $token';
    super.onRequest(options, handler);
  }
}
