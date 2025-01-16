
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:smart_rent/core/di/getit_config.dart';
import 'package:smart_rent/core/repositories/log/log.dart';

class DioProvider {
  final Log logger = getIt<Log>();
  final Dio _dio = Dio();
  final baseUrl = dotenv.get('base_url_local');

  DioProvider() {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        // Log thông tin request
        logger.d('[REQUEST]', ' ${options.method}: ${options.uri}');
        logger.d('[HEADERS]', ' ${options.headers}');
        if (options.data != null) {
          logger.d('[BODY]', ' ${options.data}');
        }
        if (options.queryParameters.isNotEmpty) {
          logger.d('[QUERY]', ' ${options.queryParameters}');
        }
        return handler.next(options); // Tiếp tục request
      },
      onResponse: (response, handler) {
        // Log thông tin response
        logger.d('[RESPONSE]', ' Status Code: ${response.statusCode}');
        logger.d('[DATA]', ' ${response.data}');
        return handler.next(response); // Tiếp tục xử lý response
      },
      onError: (DioException error, handler) {
        // Log thông tin lỗi
        logger.e('[ERROR]',
            ' ${error.response?.statusCode} ${error.response?.statusMessage}');
        logger.e('[ERROR BODY]', ' ${error.response?.data}');
        return handler.next(error); // Tiếp tục xử lý lỗi
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
