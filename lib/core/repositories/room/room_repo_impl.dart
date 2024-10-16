import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_rent/core/app/app_manager.dart';
import 'package:smart_rent/core/di/getit_config.dart';

import '../log/log.dart';
import '/core/model/response/request_model.dart';
import '/core/model/room/room.dart';
import '/core/repositories/room/room_repo.dart';

class RoomRepoImpl implements RoomRepo {
  final Log log;
  final String domain;
  final Dio dio;
  final AppManager appManager;

  RoomRepoImpl()
      : log = getIt<Log>(),
        domain = dotenv.get('base_url_prod'),
        dio = Dio(),
        appManager = AppManager();

  @override
  Future<ResponseModel<Room>> createRoom(Room room) async {
    var headers = {
      'Authorization':
          'Bearer ${appManager.accressToken}'
    };
    var data = FormData.fromMap({
      'files': [
        room.roomImages!
            .mapIndexed(
              (index, image) async => await MultipartFile.fromFile(
                  image,
                  filename:
                      '${index}_${DateTime.now().microsecondsSinceEpoch}'),
            )
            .toList(),
      ],
      'title': room.title,
      'address': room.address,
      'room_number': room.roomNumber,
      'utilities': room.utilities,
      'description': 'A spacious room with modern amenities.',
      'room_type': 'single',
      'owner': '1',
      'capacity': '2',
      'gender': '1',
      'area': '500',
      'total_price': '500',
      'deposit': '100',
      'electricity_cost': '0.5',
      'water_cost': '0.3',
      'internet_cost': '0.1',
      'is_parking': 'true',
      'parking_fee': '50',
      'status': '1',
      'is_rent': 'true',
      'address': 'phường Trường Thọ',
      'address': 'quận Thủ Đức',
      'address': 'TP HCM'
    });

    var dio = Dio();
    var response = await dio.request(
      'localhost:8080/api/v1/rooms',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      print(json.encode(response.data));
    } else {
      print(response.statusMessage);
    }

    throw UnimplementedError();
  }

  @override
  Future<bool> deleteRoom() {
    throw UnimplementedError();
  }

  @override
  Future<ResponseModel<List<Room>>> getAllRooms() async {
    final String url = '$domain/rooms';
    Response response;
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${appManager.accressToken}',
    };

    try {
      response = await dio.get(url, options: Options(headers: headers));
      return ResponseModel<List<Room>>(
        errCode: response.data['errCode'],
        message: response.data['message'],
        data: List<Room>.from(
            (response.data['data'] as List).map((room) => Room.fromMap(room))),
      );
    } catch (e) {
      log.e('getAllRooms', e.toString());
      return ResponseModel();
    }
  }

  @override
  Future<ResponseModel<Room>> getRoomById() {
    // TODO: implement getRoomById
    throw UnimplementedError();
  }

  @override
  Future<ResponseModel<Room>> updateRoom() {
    // TODO: implement updateRoom
    throw UnimplementedError();
  }
}
