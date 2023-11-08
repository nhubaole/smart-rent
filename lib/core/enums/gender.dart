enum Gender {
  ALL,
  MALE,
  FEMALE,
}

extension InfoGender on Gender {
  String getNameGender() {
    switch (this) {
      case Gender.ALL:
        return "Tất cả";
      case Gender.MALE:
        return "Nam";
      case Gender.FEMALE:
        return "Nữ";
      default:
        return "";
    }
  }
}
