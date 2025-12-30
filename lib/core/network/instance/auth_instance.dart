import 'package:dio/dio.dart';
import 'package:new_apta_grading/core/network/config/base_config.dart';
import 'package:new_apta_grading/features/auth/data/model/login_model.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';

import '../config/endpoints.dart';
import '../config/exception.dart';
import '../interceptor/delay_interceptor.dart';

class AuthAPI {
  late final Dio _dio;
  AuthAPI()
    : _dio = Dio(baseConfig)
        ..interceptors.addAll([
          DelayInterceptor(),
          TalkerDioLogger(
            settings: const TalkerDioLoggerSettings(
              printRequestHeaders: true,
              printResponseHeaders: true,
              printResponseMessage: true,
            ),
          ),
        ]);

  Future<LoginResponseModel> login(LoginInputModel loginInputModel) async {
    try {
      final response = await _dio.post(
        Endpoints.login,
        data: loginInputModel.toJson(),
      );

      return LoginResponseModel.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw DioExceptionHandler.fromDioError(e).toString();
    } catch (e) {
      throw e.toString();
    }
  }
}
