import 'package:smart_rent/core/model/room/room_create_model.dart';
import 'package:smart_rent/core/model/room/room_model.dart';

import '/core/model/response/request_model.dart';

abstract class RoomRepo {
  Future<ResponseModel<List<RoomModel>>> getAllRooms();
  Future<ResponseModel<RoomModel>> getRoomById({required int id});
  Future<ResponseModel<int>> createRoom(RoomCreateModel room);
  Future<ResponseModel<RoomModel>> updateRoom();
  Future<bool> deleteRoom();
  Future<ResponseModel<List<RoomModel>>> getRoomsByAddress({
    required String address,
  });
  Future<ResponseModel<List<RoomModel>>> getRoomsLikedByOwner();
  Future<ResponseModel<List<RoomModel>>> getRoomsByStatus(int status);
  Future<ResponseModel<bool>> getLikedRoom(int roomID);
  Future<ResponseModel<List<RoomModel>>> getByOwner();
}
