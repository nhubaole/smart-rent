import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
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
    Response response;
    final String url = '$domain/rooms';
    Map<String, dynamic>? headers = {
      'Authorization': 'Bearer ${appManager.accessToken}'
    };

    FormData formData = FormData();

    if (room.roomImages != null) {
      for (var imagePath in room.roomImages!) {
        formData.files.add(
          MapEntry(
            'room_images',
            await MultipartFile.fromFile(
              imagePath,
              filename: imagePath.split('/').last,
            ),
          ),
        );
      }
    }

    if (room.address != null) {
      for (var addressPart in room.address!) {
        formData.fields.add(MapEntry('address', addressPart));
      }
    }

    if (room.utilities != null) {
      for (var utility in room.utilities!) {
        formData.fields.add(MapEntry('utilities', utility));
      }
    }

    formData.fields
      ..add(MapEntry('title', room.title ?? ''))
      ..add(MapEntry('description', room.description ?? ''))
      ..add(MapEntry('room_type', room.roomType ?? ''))
      ..add(MapEntry('owner', appManager.userId.toString()))
      ..add(MapEntry('capacity', room.capacity?.toString() ?? ''))
      ..add(MapEntry('gender', room.gender?.toString() ?? ''))
      ..add(MapEntry('area', room.area?.toString() ?? ''))
      ..add(MapEntry('total_price', room.totalPrice?.toString() ?? ''))
      ..add(MapEntry('deposit', room.deposit?.toString() ?? ''))
      ..add(
          MapEntry('electricity_cost', room.electricityCost?.toString() ?? ''))
      ..add(MapEntry('water_cost', room.waterCost?.toString() ?? ''))
      ..add(MapEntry('internet_cost', room.internetCost?.toString() ?? ''))
      ..add(MapEntry('is_parking', room.isParking!.toString()))
      ..add(MapEntry('parking_fee', room.parkingFee?.toString() ?? ''))
      ..add(MapEntry('status', room.status?.toString() ?? ''))
      ..add(MapEntry('is_rent', room.isRent.toString()));

    print(formData.fields);

    try {
      response = await dio.request(
        url,
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: formData,
      );

      print(response.data);

      return ResponseModel<Room>(
        errCode: response.data['errCode'],
        message: response.data['message'],
        data: Room.fromMap(
          response.data['data'],
        ),
      );
    } catch (e) {
      log.e('createRoom', e.toString());
      return ResponseModel();
    }
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
      'Authorization': 'Bearer ${appManager.accessToken}',
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

  @override
  Future<ResponseModel<List<Room>>> getRoomsByAddress({
    required String address,
  }) async {
    final String url = '$domain/rooms/search-by-address?search=$address';

    if (appManager.accessToken == null) {
      return ResponseModel(errCode: -1, message: 'Bạn chưa đăng nhập');
    }

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${appManager.accessToken}',
    };

    try {
      final response = await dio.get(url, options: Options(headers: headers));

      if (response.statusCode == 200 && response.data is Map) {
        try {
          return ResponseModel<List<Room>>(
            errCode: response.data['errCode'],
            message: response.data['message'],
            data: List<Room>.from((response.data['data'] as List)
                .map((room) => Room.fromMap(room))),
          );
        } catch (e) {
          log.e('getRoomsByAddress: Lỗi parse JSON', e.toString());
          return ResponseModel(errCode: -1, message: 'Lỗi parse JSON');
        }
      } else {
        log.e('getRoomsByAddress: Lỗi server',
            'Status code: ${response.statusCode}, Response data: ${response.data}');
        return ResponseModel(
            errCode: response.statusCode, message: 'Lỗi server');
      }
    } catch (e) {
      log.e('getRoomsByAddress: Lỗi kết nối', e.toString());
      return ResponseModel(errCode: -1, message: 'Lỗi kết nối');
    }
  }
}
