import 'package:get/get.dart';
import 'package:smart_rent/core/values/image_assets.dart';

enum RatingLevel {
  TERRIBLE,
  BAD,
  AVERAGE,
  GOOD,
  EXCELLENT,
}

extension RatingLevelExt on RatingLevel {
  String get name {
    switch (this) {
      case RatingLevel.TERRIBLE:
        return 'terrible'.tr;
      case RatingLevel.BAD:
        return 'bad'.tr;
      case RatingLevel.AVERAGE:
        return 'average'.tr;
      case RatingLevel.GOOD:
        return 'good'.tr;
      case RatingLevel.EXCELLENT:
        return 'excellent'.tr;
    }
  }

  String get icon {
    switch (this) {
      case RatingLevel.TERRIBLE:
        return ImageAssets.icTerrible;
      case RatingLevel.BAD:
        return ImageAssets.icBad;
      case RatingLevel.AVERAGE:
        return ImageAssets.icAverage;
      case RatingLevel.GOOD:
        return ImageAssets.icGood;
      case RatingLevel.EXCELLENT:
        return ImageAssets.icExcellent;
    }
  }

  int get value {
    switch (this) {
      case RatingLevel.TERRIBLE:
        return 1;
      case RatingLevel.BAD:
        return 2;
      case RatingLevel.AVERAGE:
        return 3;
      case RatingLevel.GOOD:
        return 4;
      case RatingLevel.EXCELLENT:
        return 5;
    }
  }

  RatingLevel valueToEnum(int value) {
    switch (value) {
      case 1:
        return RatingLevel.TERRIBLE;
      case 2:
        return RatingLevel.BAD;
      case 3:
        return RatingLevel.AVERAGE;
      case 4:
        return RatingLevel.GOOD;
      case 5:
        return RatingLevel.EXCELLENT;
      default:
        return RatingLevel.AVERAGE;
    }
  }

  RatingLevel get next {
    switch (this) {
      case RatingLevel.TERRIBLE:
        return RatingLevel.BAD;
      case RatingLevel.BAD:
        return RatingLevel.AVERAGE;
      case RatingLevel.AVERAGE:
        return RatingLevel.GOOD;
      case RatingLevel.GOOD:
        return RatingLevel.EXCELLENT;
      case RatingLevel.EXCELLENT:
        return RatingLevel.EXCELLENT;
    }
  }

  RatingLevel get previous {
    switch (this) {
      case RatingLevel.TERRIBLE:
        return RatingLevel.TERRIBLE;
      case RatingLevel.BAD:
        return RatingLevel.TERRIBLE;
      case RatingLevel.AVERAGE:
        return RatingLevel.BAD;
      case RatingLevel.GOOD:
        return RatingLevel.AVERAGE;
      case RatingLevel.EXCELLENT:
        return RatingLevel.GOOD;
    }
  }
}
