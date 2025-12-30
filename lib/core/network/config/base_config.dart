import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final BaseOptions baseConfig = BaseOptions(
  baseUrl: dotenv.env['BASE_URL']!,
  connectTimeout: Duration(
    seconds: int.parse(dotenv.env['CONNECTION_TIMEOUT']!),
  ),
  receiveTimeout: Duration(seconds: int.parse(dotenv.env['TIMEOUT_DURATION']!)),
  responseType: ResponseType.json,
);
