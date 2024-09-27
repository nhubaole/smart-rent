extension BoolExt on bool {
  String get getStatusRoom {
    return this ? 'available' : 'unavailable';
  }
}
