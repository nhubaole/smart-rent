import 'package:smart_rent/core/model/rating/rating_by_id_room_model.dart';
import 'package:smart_rent/core/model/rating/rating_landlord_create_model.dart';
import 'package:smart_rent/core/model/rating/rating_room_create_model.dart';
import 'package:smart_rent/core/model/rating/rating_tenant_create_model.dart';
import 'package:smart_rent/core/model/response/request_model.dart';

abstract class RatingRepo {
  Future<ResponseModel<RatingByIdRoomModel>> getRatingByIdRoom(
      {required int id});
  Future<ResponseModel<bool>> createRatingTenant(
      {required RatingTenantCreateModel ratingTenantCreateModel});
  Future<ResponseModel<bool>> createRatingLandlord(
      {required RatingLandlordCreateModel ratingLandlordCreateModel});
  Future<ResponseModel<bool>> createRatingRoom(
      {required RatingRoomCreateModel ratingRoomCreateModel});
}
