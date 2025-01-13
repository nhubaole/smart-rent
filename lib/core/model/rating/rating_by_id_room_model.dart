// {
//     "total_rating": 2,
//     "detail_count": {
//         "4": 1,
//         "5": 1
//     },
//     "avg_rating": 4.5000000000000000,
//     "rating_info": [
//         {
//             "comment": "Nice room, good location",
//             "created_at": "2024-10-02T10:30:28.228166",
//             "happy": "vị trí tốt,tiện nghi",
//             "images": [
//                 "https://smartrental.s3.ap-southeast-1.amazonaws.com/rating-images/user_1/1727865024964.png",
//                 "https://smartrental.s3.ap-southeast-1.amazonaws.com/rating-images/user_1/1727865025375.png"
//             ],
//             "rate": 4,
//             "rater_name": "là văn tã",
//             "unhappy": "không sạch sẽ"
//         },
//         {
//             "comment": "đẹp",
//             "created_at": "2024-12-19T09:41:02.750143",
//             "happy": "vị trí tốt,tiện nghi",
//             "images": null,
//             "rate": 5,
//             "rater_name": "là văn tã",
//             "unhappy": "không sạch sẽ"
//         }
//     ]
// }

import 'package:smart_rent/core/model/rating/rating_info_model.dart';

class RatingByIdRoomModel {
  int? totalRating;
  Map<String, int>? detailCount;
  double? avgRating;
  List<RatingInfoModel>? ratingInfo;

  RatingByIdRoomModel({
    this.totalRating,
    this.detailCount,
    this.avgRating,
    this.ratingInfo,
  });

  RatingByIdRoomModel copyWith({
    int? totalRating,
    Map<String, int>? detailCount,
    double? avgRating,
    List<RatingInfoModel>? ratingInfo,
  }) {
    return RatingByIdRoomModel(
      totalRating: totalRating ?? this.totalRating,
      detailCount: detailCount ?? this.detailCount,
      avgRating: avgRating ?? this.avgRating,
      ratingInfo: ratingInfo ?? this.ratingInfo,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'total_rating': totalRating,
      'detail_count': detailCount,
      'avg_rating': avgRating,
      'rating_info': ratingInfo?.map((x) => x.toMap()).toList(),
    };
  }

  factory RatingByIdRoomModel.fromMap(Map<String, dynamic> map) {
    return RatingByIdRoomModel(
      totalRating:
          map['total_rating'] != null ? map['total_rating'] as int : null,
      detailCount: map['detail_count'] != null
          ? Map<String, int>.from(map['detail_count'])
          : null,
      avgRating: map['avg_rating'] != null ? map['avg_rating'] as double : null,
      ratingInfo: map['rating_info'] != null
          ? List<RatingInfoModel>.from(
              (map['rating_info'] as List)
                  .map((x) => RatingInfoModel.fromJson(x))
                  .toList(),
            )
          : null,
    );
  }
}
