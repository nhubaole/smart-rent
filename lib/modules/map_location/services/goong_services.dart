import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:smart_rent/core/di/getit_config.dart';
import 'package:smart_rent/core/model/response/request_model.dart';
import 'package:smart_rent/core/repositories/dio/dio_provider.dart';
import 'package:smart_rent/core/repositories/log/log.dart';

class GoongServices {
  static final GoongServices _instance = GoongServices._internal();

  factory GoongServices() => _instance;

  GoongServices._internal();

  static Log log = getIt<Log>();

  Future<ResponseModel<List<String>>> getAutoComplete(String query) async {
    final domain = dotenv.get('goong_url');
    final apiKey = dotenv.get('goong_api_key');
    final url = '/Place/AutoComplete/?api_key=$apiKey&input=$query';
    try {
      final response = await DioProvider(baseUrl: domain).get(
        url,
      );
      return ResponseModel<List<String>>(
        errCode: response.data['errCode'] ?? 200,
        message: response.data['message'] ?? 'success',
        data: response.data['predictions'] != null
            ? List<String>.from((response.data['predictions'] as List)
                .map((s) => s['description'] as String))
            : [],
      );
    } catch (e) {
      log.e('getRoomsByAddressElasticSearch: Lỗi kết nối', e.toString());
      return ResponseModel.failed(e);
    }
  }
}
