class RatingInfoModel {
  String? raterName;
  DateTime? createdAt;
  int? rate;
  String? comment;
  String? happy;
  List<String>? images;
  String? unHappy;
  String? raterAvatar;

  RatingInfoModel({
    this.raterName,
    this.createdAt,
    this.rate,
    this.comment,
    this.happy,
    this.unHappy,
    this.images,
    this.raterAvatar,
  });

  factory RatingInfoModel.fromJson(Map<String, dynamic> json) {
    return RatingInfoModel(
      raterName: json['rater_name'],
      createdAt: DateTime.parse(json['created_at']),
      rate: json['rate'],
      images: json['images'] != null
          ? List<String>.from(
              (json['images'] as List).map((e) => e as String).toList(),
            )
          : null,
      comment: json['comment'],
      happy: json['happy'],
      unHappy: json['unhappy'],
      raterAvatar: json['rater_avatar'],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'rater_name': raterName,
      'created_at': createdAt?.toIso8601String(),
      'rate': rate,
      'comment': comment,
      'happy': happy,
      'unhappy': unHappy,
      'images': images,
      'rater_avatar': raterAvatar,
    };
  }
}
