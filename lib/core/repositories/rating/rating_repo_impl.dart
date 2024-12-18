import 'package:smart_rent/core/app/app_manager.dart';
import 'package:smart_rent/core/di/getit_config.dart';
import 'package:smart_rent/core/model/rating/rating_by_id_room_model.dart';
import 'package:smart_rent/core/model/rating/rating_tenant_create_model.dart';
import 'package:smart_rent/core/model/response/request_model.dart';
import 'package:smart_rent/core/repositories/dio/dio_provider.dart';
import 'package:smart_rent/core/repositories/log/log.dart';
import 'package:smart_rent/core/repositories/rating/rating_repo.dart';

class RatingRepoImpl extends RatingRepo {
  final Log log;
  final DioProvider dio;
  RatingRepoImpl()
      : log = getIt<Log>(),
        dio = DioProvider();
  @override
  Future<ResponseModel<RatingByIdRoomModel>> getRatingByIdRoom({
    required int id,
  }) async {
    final String url = '/ratings/$id';

    try {
      final response = await dio.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AppManager().accessToken}',
        },
      );

      return ResponseModel<RatingByIdRoomModel>(
        errCode: response.data['errCode'],
        message: response.data['message'],
        data: RatingByIdRoomModel.fromMap(response.data['data']),
      );
    } catch (e) {
      log.e('getRatingByIdRoom', e.toString());
      return ResponseModel.failed(e);
    }
  }

  @override
  Future<ResponseModel<bool>> createRatingTenant({
    required RatingTenantCreateModel ratingTenantCreateModel,
  }) async {
    const String url = '/ratings/create-tenant-rating';
    final formData = await ratingTenantCreateModel.toFormData();
    try {
      final response = await dio.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AppManager().accessToken}',
        },
        data: formData,
      );

      return ResponseModel<bool>(
        errCode: response.data['errCode'],
        message: response.data['message'],
        data: response.data['data'] as bool,
      );
    } catch (e) {
      log.e('getRatingByIdRoom', e.toString());
      return ResponseModel.failed(e);
    }
  }
}
