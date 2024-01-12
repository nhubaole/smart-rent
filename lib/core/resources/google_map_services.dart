import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapServices {
  String encodeUrl(String address) {
    var encoded = Uri.encodeFull(address);
    return encoded.replaceAll(',', '');
  }

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

  Future<LatLng> getLatLngFromAddress(
    String address,
    String language,
  ) async {
    address = encodeUrl(address);

    LatLng? latLng;
    try {
      var dio = Dio();
      var response = await dio.request(
        '${dotenv.env['google_map_url']}/geocode/json?address=$address&key=${dotenv.env['google_map_api']}&language=$language',
        options: Options(
          method: 'GET',
        ),
      );

      if (response.statusCode == 200) {
        var result = Map<String, dynamic>.from(response.data);

        double? lat = double.tryParse(
            result['results'][0]['geometry']['location']['lat'].toString());
        double? lon = double.tryParse(
            result['results'][0]['geometry']['location']['lng'].toString());

        if (lat != null && lon != null) {
          latLng = LatLng(lat, lon);
        } else {
          latLng = const LatLng(0, 0);
        }
      } else {
        print(response.statusMessage);
      }
    } catch (e) {
      print(e.toString());
    }

    return latLng!;
  }
}
