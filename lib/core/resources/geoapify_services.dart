import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GeoApiFyServices {
  Future<Map<String, dynamic>> getCurrentLocation(
      double? lat, double? lon) async {
    Map<String, dynamic> result = {};
    try {
      var dio = Dio();
      var response = await dio.request(
        '${dotenv.env['geoapify_url']}/geocode/reverse?lat=$lat&lon=$lon&apiKey=${dotenv.env['geoapify_url_api']}',
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

  String convertAddress(String address) {
    String encodedAddress = Uri.encodeComponent(address);

    return encodedAddress;
  }

  Future<Map<String, dynamic>> getAddressMap(String address) async {
    Map<String, dynamic> result = {};
    try {
      var dio = Dio();
      var response = await dio.request(
        '${dotenv.env['geoapify_url']}/geocode/search?text=${convertAddress(address)}&format=json&apiKey=${dotenv.env['geoapify_url_api']}',
        options: Options(
          method: 'GET',
        ),
      );

      if (response.statusCode == 200) {
        result = Map<String, dynamic>.from(response.data);
        print(result);
      } else {
        print(response.statusMessage);
      }
    } catch (e) {
      print(e.toString());
    }
    return result;
  }

  Future<Map<String, dynamic>> getRoutePlayGround(
    double? lat0,
    double? lon0,
    double? lat1,
    double? lon1,
  ) async {
    Map<String, dynamic> result = {};
    try {
      var dio = Dio();
      var response = await dio.request(
        '${dotenv.env['geoapify_url']}/routing?waypoints=$lat0,$lon0|$lat1,$lon1&mode=drive&apiKey=${dotenv.env['geoapify_url_api']}',
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
