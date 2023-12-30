import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GoogleMapServices {
  Future<Map<String, dynamic>> convertLatLngToAddress(
    double lat,
    double lon,
    String language,
  ) async {
    Map<String, dynamic> result = {};
    try {
      var dio = Dio();
      var response = await dio.request(
        '${dotenv.env['google_map_url']}/geocode/json?latlng=$lat,$lon&key=${dotenv.env['google_map_api']}&language=$language',
        options: Options(
          method: 'GET',
        ),
      );

      if (response.statusCode == 200) {
        result = Map<String, dynamic>.from(response.data);
      } else {
        print(response.statusMessage);
      }
    } catch (e) {
      print(e.toString());
    }

    return result;
  }
}
