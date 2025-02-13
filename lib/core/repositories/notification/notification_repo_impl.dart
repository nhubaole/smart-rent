import 'package:dio/dio.dart';
import 'package:smart_rent/core/app/app_manager.dart';
import 'package:smart_rent/core/di/getit_config.dart';
import 'package:smart_rent/core/model/notification_model.dart';
import 'package:smart_rent/core/model/response/request_model.dart';
import 'package:smart_rent/core/repositories/dio/dio_provider.dart';
import 'package:smart_rent/core/repositories/log/log.dart';
import 'package:smart_rent/core/repositories/notification/notification_repo.dart';

class NotificationRepoImpl extends NotificationRepo {
  final Log log;
  final DioProvider dio;
  NotificationRepoImpl()
      : log = getIt<Log>(),
        dio = DioProvider();

  @override
  Future<ResponseModel<List<NotificationModel>>> getAllNotifications() async {
    const String url = '/notifications';
    Response response;

    try {
      response = (await dio.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AppManager().accessToken}',
        },
      ));

      return ResponseModel<List<NotificationModel>>(
        errCode: response.data['errCode'],
        message: response.data['message'],
        data: List<NotificationModel>.from(
          (response.data['data'] as List)
            .map((x) => NotificationModel.fromMap(x))
        ),
      );
    } catch (e) {
      log.e('getAllNotifications', e.toString());
      return ResponseModel.failed(e);
    }
  }
}
