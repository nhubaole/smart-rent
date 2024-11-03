import '/core/model/response/request_model.dart';
import '/core/model/room/room.dart';

abstract class RoomRepo {
  Future<ResponseModel<List<Room>>> getAllRooms();
  Future<ResponseModel<Room>> getRoomById();
  Future<ResponseModel<int>> createRoom(Room room);
  Future<ResponseModel<Room>> updateRoom();
  Future<bool> deleteRoom();
  Future<ResponseModel<List<Room>>> getRoomsByAddress({
    required String address,
  });
}
