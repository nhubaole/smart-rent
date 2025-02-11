import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smart_rent/core/app/app_manager.dart';
import 'package:smart_rent/core/di/getit_config.dart';
import 'package:smart_rent/core/model/room/room_create_model.dart';
import 'package:smart_rent/core/model/room/room_model.dart';
import 'package:smart_rent/core/repositories/dio/dio_provider.dart';

import '../log/log.dart';
import '/core/model/response/request_model.dart';
import '/core/repositories/room/room_repo.dart';

class RoomRepoImpl implements RoomRepo {
  final Log log;
  final DioProvider dio;
  RoomRepoImpl()
      : log = getIt<Log>(),
        dio = DioProvider();

  @override
  Future<bool> deleteRoom() {
    throw UnimplementedError();
  }

  @override
  Future<ResponseModel<List<RoomModel>>> getAllRooms() async {
    const String url = '/rooms';
    try {
      final response = await dio.get(
        url,
        headers: {
      'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AppManager().accessToken}',
        },
      );
      
      return ResponseModel<List<RoomModel>>(
        errCode: response.data['errCode'],
        message: response.data['message'],
        data: _handleListRoomResponse(response.data['data']),
      );
    } catch (e) {
      log.e('getAllRooms', e.toString());
      return ResponseModel.failed(e);
    }
  }

  @override
  Future<ResponseModel<RoomModel>> getRoomById({required int id}) async {
    final url = '/rooms/$id';
    try {
      final response = await dio.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AppManager().accessToken}',
        },
      );

      return ResponseModel<RoomModel>(
        errCode: response.data['errCode'],
        message: response.data['message'],
        data: _handleRoomResponse(response.data['data']),
      );
    } catch (e) {
      log.e('getRoomById', e.toString());
      return ResponseModel.failed(e);
    }
  }

  @override
  Future<ResponseModel<RoomModel>> updateRoom() {
    throw UnimplementedError();
  }

  @override
  Future<ResponseModel<List<RoomModel>>> getRoomsByAddress({
    required String address,
  }) async {
    final String url = '/rooms/search-by-address?search=$address';

    try {
      final response = await dio.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AppManager().accessToken}',
        },
      );

      return ResponseModel<List<RoomModel>>(
        errCode: response.data['errCode'],
        message: response.data['message'],
        data: _handleListRoomResponse(response.data['data']),
      );
    } catch (e) {
      log.e('getRoomsByAddress: Lỗi kết nối', e.toString());
      return ResponseModel(errCode: -1, message: 'Lỗi kết nối');
    }
  }
  
  @override
  Future<ResponseModel<List<RoomModel>>> getRoomsLikedByOwner() async {
    const String url = '/rooms/like';

    try {
      final response = await dio.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AppManager().accessToken}',
        },
      );

      return ResponseModel<List<RoomModel>>(
        errCode: response.data['errCode'],
        message: response.data['message'],
        data: response.data['data'] != null
            ? List<RoomModel>.from((response.data['data'] as List)
                .map((room) => RoomModel.fromMap(room)))
            : [],
      );
    } catch (e) {
      log.e('getRoomsLikedByOwner', e.toString());
      return ResponseModel.failed(e);
    }
  }

  @override
  Future<ResponseModel<List<RoomModel>>> getRoomsByStatus(int status) async {
    final String url = '/rooms/status/$status';

    try {
      final response = await dio.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AppManager().accessToken}',
        },
      );

      return ResponseModel<List<RoomModel>>(
        errCode: response.data['errCode'],
        message: response.data['message'],
        data: List<RoomModel>.from((response.data['data'] as List)
            .map((room) => RoomModel.fromMap(room))),
      );
    } catch (e) {
      log.e('getRoomsByStatus', e.toString());
      return ResponseModel.failed(e);
    }
  }

  @override
  Future<ResponseModel<int>> createRoom(RoomCreateModel room) async {
    final String url = '/rooms';
    final formData = await room.toFormData();
    try {
      final response = await dio.post(
        url,
        headers: {'Authorization': 'Bearer ${AppManager().accessToken}'},
        data: formData,
      );

      return ResponseModel<int>(
        errCode: response.data['errCode'],
        message: response.data['message'],
        data: response.data['data'] as int,
      );
    } catch (e) {
      log.e('createRoom', e.toString());
      return ResponseModel.failed(e);
    }
  }
  
  @override
  Future<ResponseModel<bool>> getLikedRoom(int roomID) async {
    final String url = '/rooms/like/$roomID';

    try {
      final response = await dio.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AppManager().accessToken}',
        },
      );

      return ResponseModel<bool>(
        errCode: response.data['errCode'],
        message: response.data['message'],
        data: response.data['data']['isLiked'] as bool,
      );
    } catch (e) {
      log.e('getLikedRoom', e.toString());
      return ResponseModel.failed(e);
    }
  }

  @override
  Future<ResponseModel<List<RoomModel>>> getByOwner() async {
    const String url = '/rooms/get-by-owner';

    try {
      final response = await dio.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AppManager().accessToken}',
        },
      );

      return ResponseModel<List<RoomModel>>(
        errCode: response.data['errCode'],
        message: response.data['message'],
        data: _handleListRoomResponse(response.data['data']),
      );
    } catch (e) {
      log.e('getByOwner', e.toString());
      return ResponseModel.failed(e);
    }
  }
  
  @override
  Future<ResponseModel<List<RoomModel>>> getRoomsByAddressElasticSearch(
      {required String address}) async {
    const String url = '/rooms/_search';
    final body = {
      'query': {
        'match': {
          'address': {
            'query': address,
            'fuzziness': 'AUTO',
          }
        }
      }
    };
    try {
      final response =
          await DioProvider(baseUrl: dotenv.get('base_elasticsearch')).get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AppManager().accessToken}',
        },
        data: json.encode(body),
      );

      return ResponseModel<List<RoomModel>>(
        errCode: response.data['errCode'] ?? 200,
        message: response.data['message'] ?? 'success',
        data: _handleDataFromElastic(response.data),
      );
    } catch (e) {
      log.e('getRoomsByAddressElasticSearch: Lỗi kết nối', e.toString());
      return ResponseModel(errCode: -1, message: 'Lỗi kết nối');
    }
  }

  @override
  Future<ResponseModel<List<RoomModel>>>
      getRoomsByAddressAndLocationElasticSearch(
          {required double distance, required LatLng location}) async {
    const String url = '/rental.public.rooms/_search';
    final body = {
      'query': {
        'bool': {
          'filter': {
            'geo_distance': {
              'distance': '${distance}km',
              'geo_location': {
                'lon': location.longitude,
                'lat': location.latitude,
              }
            }
          }
        }
      }
    };
    try {
      final response =
          await DioProvider(baseUrl: dotenv.get('base_elasticsearch')).get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AppManager().accessToken}',
        },
        data: json.encode(body),
      );

      return ResponseModel<List<RoomModel>>(
        errCode: response.data['errCode'] ?? 200,
        message: response.data['message'] ?? 'success',
        data: _handleDataFromElastic(response.data),
      );
    } catch (e) {
      log.e('getRoomsByAddressAndLocationElasticSearch: Lỗi kết nối',
          e.toString());
      return ResponseModel(errCode: -1, message: 'Lỗi kết nối');
    }
  }

  _handleListRoomResponse(dynamic data) {
    if (data['rooms'] == null ||
        data['rooms'] is List && data['rooms'].isEmpty) {
      return <RoomModel>[];
    }
    return List<RoomModel>.from(
        (data['rooms'] as List).map((room) => RoomModel.fromMap(room)));
  }

  _handleRoomResponse(Map<String, dynamic> data) {
    return RoomModel.fromMap(data);
  }

  _handleDataFromElastic(dynamic data) {
    if (data['hits']['hits'] == null ||
        (data['hits']['hits'] as List).isEmpty) {
      return <RoomModel>[];
    }

    return List<RoomModel>.from((data['hits']['hits'] as List).map((room) =>
        RoomModel.fromMap(room['_source'],
            id: int.tryParse(room['_id']) ?? 0)));
  }
}
