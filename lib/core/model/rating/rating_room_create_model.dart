import 'package:dio/dio.dart';

class RatingRoomCreateModel {
  int? roomId;
  int? amenitiesRating;
  int? locationRating;
  int? cleanlinessRating;
  int? priceRating;
  int? overralRating;
  String? comments;
  List<String>? images;

  RatingRoomCreateModel({
    this.roomId,
    this.amenitiesRating,
    this.locationRating,
    this.cleanlinessRating,
    this.priceRating,
    this.overralRating,
    this.comments,
    this.images,
  });

  Future<FormData> toFormData() async {
    FormData formData = FormData();
    if (images != null) {
      for (final imagePath in images!) {
        formData.files.add(
          MapEntry(
            'images',
            await MultipartFile.fromFile(
              imagePath,
            ),
          ),
        );
      }
    }

    formData.fields
      ..add(MapEntry('room_id', roomId.toString()))
      ..add(MapEntry('amenities_rating', amenitiesRating.toString()))
      ..add(MapEntry('location_rating', locationRating.toString()))
      ..add(MapEntry('cleanliness_rating', cleanlinessRating.toString()))
      ..add(MapEntry('price_rating', priceRating.toString()))
      ..add(MapEntry('overall_rating', overralRating.toString()))
      ..add(MapEntry('comments', comments ?? ''));

    return formData;
  }
}
