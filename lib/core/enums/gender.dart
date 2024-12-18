enum Gender {
  ALL,
  MALE,
  FEMALE,
}

extension InfoGender on Gender {
  String get getNameGender {
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

  int get getNameGenderInt {
    switch (this) {
      case Gender.ALL:
        return -1;
      case Gender.MALE:
        return 0;
      case Gender.FEMALE:
        return 1;
      default:
        return -1;
    }
  }

  static Gender fromString(String value) {
    switch (value) {
      case "Tất cả":
        return Gender.ALL;
      case "Nam":
        return Gender.MALE;
      case "Nữ":
        return Gender.FEMALE;
      default:
        throw ArgumentError('Invalid room type: $value');
    }
  }

  static Gender fromInt(int value) {
    switch (value) {
      case -1:
        return Gender.ALL;
      case 0:
        return Gender.MALE;
      case 1:
        return Gender.FEMALE;
      default:
        throw ArgumentError('Invalid room type: $value');
    }
  }
}
