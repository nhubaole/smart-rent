enum RoomStatus {
  PENDING,
  APPROVED,
  EXPIRED,
  DELETED,
  REQUESTRENT,
  REQUESTRETURN,
  RENTED,
}

extension InfoRoomType on RoomStatus {
  String getNameRoomType() {
    switch (this) {
      case RoomStatus.PENDING:
        return "Đang chờ duyệt";
      case RoomStatus.APPROVED:
        return "Đã duyệt";
      case RoomStatus.EXPIRED:
        return "Hết hạn";
      case RoomStatus.DELETED:
        return "Đã xóa";
      case RoomStatus.REQUESTRENT:
        return "Yêu cầu thuê";
      case RoomStatus.REQUESTRETURN:
        return "Yêu cầu trả";
      case RoomStatus.RENTED:
        return "Đã thuê";
      default:
        return "";
    }
  }
}
