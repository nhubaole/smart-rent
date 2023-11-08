enum RoomStatus { PENDING, APPROVED, EXPIRED, DELETED }

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
      default:
        return "";
    }
  }
}
