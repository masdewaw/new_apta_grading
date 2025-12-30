import 'package:dio/dio.dart';

class DelayInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // ignore: avoid_print
    print("DelayInterceptor triggered for ${options.method} ${options.path}");
    await Future.delayed(const Duration(seconds: 3));
    handler.next(options); // ini yang harus dipanggil, bukan super.onRequest
  }
}
