enum RoomType {
  DORMITORY_HOMESTAY,
  ROOM,
  WHOLE_HOUSE,
  APARTMENT,
}

extension InfoRoomType on RoomType {
  String get value {
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
        return "Chua dinh nghia";
    }
  }

  static RoomType fromString(String value) {
    switch (value.toUpperCase()) {
      case "Kí túc xá/Homestay":
        return RoomType.DORMITORY_HOMESTAY;
      case "Phòng cho thuê":
        return RoomType.ROOM;
      case "Nhà nguyên căn":
        return RoomType.WHOLE_HOUSE;
      case "Căn hộ":
        return RoomType.APARTMENT;
      default:
        return RoomType.APARTMENT;
    }
  }
}
