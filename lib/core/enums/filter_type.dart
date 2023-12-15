enum FilterType { PRICE, UTIL, ROOM_TYPE, CAPACITY, SORT }

extension InfoFilterType on FilterType {
  String getNameFilterType() {
    switch (this) {
      case FilterType.PRICE:
        return "Giá cả";
      case FilterType.UTIL:
        return "Tiện ích";
      case FilterType.ROOM_TYPE:
        return "Loại phòng";
      case FilterType.CAPACITY:
        return "Số người";
      case FilterType.SORT:
        return "Sắp xếp";
      default:
        return "";
    }
  }
}
