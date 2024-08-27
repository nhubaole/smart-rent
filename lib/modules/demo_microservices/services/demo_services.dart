import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:smart_rent/modules/demo_microservices/models/room_response_model.dart';

class DemoServices {
  DemoServices._internal();
  static final DemoServices instance = DemoServices._internal();
  factory DemoServices() => instance;

  Future<List<RoomResponseModel>?> getListRooms({
    required String token,
    required int pageIndex,
    required int pageCount,
  }) async {
    try {
      var headers = {'Authorization': 'Bearer $token'};
      var dio = Dio();
      var response = await dio.request(
        'https://${dotenv.get('localhost_wan')}:3001/api-gateway/v1/rooms?pageIndex=$pageIndex&pageCount=$pageCount',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        print(response.data['rooms']);

        List<RoomResponseModel> list = [];

        for (var i in response.data['rooms']['rooms'] as List) {
          list.add(RoomResponseModel.fromMap(i));
        }
        return list;
      } else {
        debugPrint('[DemoServices][getListRooms]: ${response.statusMessage}');
        return null;
      }
    } catch (e) {
      debugPrint('[DemoServices][getListRooms]: ${e.toString()}');
      return null;
    }
  }
}
