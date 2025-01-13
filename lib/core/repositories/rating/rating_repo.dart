import 'package:smart_rent/core/model/rating/rating_by_id_room_model.dart';
import 'package:smart_rent/core/model/rating/rating_tenant_create_model.dart';
import 'package:smart_rent/core/model/response/request_model.dart';

abstract class RatingRepo {
  Future<ResponseModel<RatingByIdRoomModel>> getRatingByIdRoom(
      {required int id});
  Future<ResponseModel<bool>> createRatingTenant(
      {required RatingTenantCreateModel ratingTenantCreateModel});
}
