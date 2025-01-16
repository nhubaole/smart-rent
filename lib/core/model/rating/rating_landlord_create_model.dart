// {
//     "landlord_id": 2,
//     "friendliness_rating": 3,
//     "professionalism_rating": 1,
//     "support_rating": 3,
//     "transparency_rating": 2,
//     "overall_rating": 1,
//     "comments": "xau tinh"
// }

import 'dart:convert';

class RatingLandlordCreateModel {
  int? landlordId;
  int? friendlinessRating;
  int? professionalismRating;
  int? supportRating;
  int? transparencyRating;
  int? overallRating;
  String? comments;

  RatingLandlordCreateModel({
    this.landlordId,
    this.friendlinessRating,
    this.professionalismRating,
    this.supportRating,
    this.transparencyRating,
    this.overallRating,
    this.comments,
  });

  Map<String, dynamic> toMap() {
    return {
      'landlord_id': landlordId,
      'friendliness_rating': friendlinessRating,
      'professionalism_rating': professionalismRating,
      'support_rating': supportRating,
      'transparency_rating': transparencyRating,
      'overall_rating': overallRating,
      'comments': comments,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'RatingLandlordCreateModel(landlordId: $landlordId, friendlinessRating: $friendlinessRating, professionalismRating: $professionalismRating, supportRating: $supportRating, transparencyRating: $transparencyRating, overallRating: $overallRating, comments: $comments)';
  }
}
