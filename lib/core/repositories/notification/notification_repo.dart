import 'package:smart_rent/core/model/notification_model.dart';
import 'package:smart_rent/core/model/response/request_model.dart';

abstract class NotificationRepo {
  Future<ResponseModel<List<NotificationModel>>> getAllNotifications();
}
