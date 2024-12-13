import 'package:get/get.dart';

enum TypeFaculty {
  electricity,
  water,
}

extension TypeFacultyExtension on TypeFaculty {
  String get name {
    switch (this) {
      case TypeFaculty.electricity:
        return 'electricity'.tr;
      case TypeFaculty.water:
        return 'water'.tr;
    }
  }
}
