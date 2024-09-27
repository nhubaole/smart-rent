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
  Future<ResponseModel<Room>> createRoom() {
    // TODO: implement createRoom
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
