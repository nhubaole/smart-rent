enum RoomType {
  DORMITORY_HOMESTAY,
  ROOM,
  WHOLE_HOUSE,
  APARTMENT,
}

extension InfoRoomType on RoomType {
  String getNameRoomType() {
    switch (this) {
      case RoomType.DORMITORY_HOMESTAY:
        return "Kí túc xá/Homestay";
      case RoomType.ROOM:
        return "Phòng cho thuê";
      case RoomType.WHOLE_HOUSE:
        return "Nhà nguyên căn";
      case RoomType.APARTMENT:
        return "Căn hộ";
      default:
        return "";
    }
  }
}
