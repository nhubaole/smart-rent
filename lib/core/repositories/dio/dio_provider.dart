
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:smart_rent/core/di/getit_config.dart';
import 'package:smart_rent/core/repositories/log/log.dart';

class DioProvider {
  final Log logger = getIt<Log>();
  final Dio _dio = Dio();
  final baseUrl = dotenv.get('base_url_prod');

  DioProvider() {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        options.connectTimeout = const Duration(seconds: 5);
        options.receiveTimeout = const Duration(seconds: 5);
        return handler.next(options);
      },
    ));
  }

  Future<Response<dynamic>> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    logger.d('[DIOPROVIDER] GET: ', '$baseUrl$url');
    return await _dio.get(
      '$baseUrl$url',
      queryParameters: queryParameters,
      options: Options(headers: headers),
    );
  }

  Future<Response<dynamic>> post(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    logger.d('[DIOPROVIDER] POST: ', '$baseUrl$url');
    return await _dio.post(
      '$baseUrl$url',
      data: data,
      queryParameters: queryParameters,
      options: Options(headers: headers),
    );
  }

  Future<Response<dynamic>> put(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    logger.d('[DIOPROVIDER] PUT: ', '$baseUrl$url');
    return await _dio.put(
      '$baseUrl$url',
      data: data,
      queryParameters: queryParameters,
      options: Options(headers: headers),
    );
  }

  Future<Response<dynamic>> delete(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    logger.d('[DIOPROVIDER] DELETE: ', '$baseUrl$url');
    return await _dio.delete(
      '$baseUrl$url',
      data: data,
      queryParameters: queryParameters,
      options: Options(headers: headers),
    );
  }

  Future<Response<dynamic>> patch(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    logger.d('[DIOPROVIDER] PATCH: ', '$baseUrl$url');
    return await _dio.patch(
      '$baseUrl$url',
      data: data,
      queryParameters: queryParameters,
      options: Options(headers: headers),
    );
  }
}
