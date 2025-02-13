import 'package:smart_rent/core/model/rental_request/all_process_tracking_model.dart';
import 'package:smart_rent/core/model/rental_request/process_tracking_by_id_model.dart';
import 'package:smart_rent/core/model/rental_request/rental_request_all_model.dart';
import 'package:smart_rent/core/model/rental_request/rental_request_by_id_model.dart';
import 'package:smart_rent/core/model/rental_request/rental_request_create_model.dart';
import 'package:smart_rent/core/model/response/request_model.dart';

abstract class RentalRequestRepo {
  Future<ResponseModel<List<RentalRequestAllModel>>> getAllRentalRequest();
  //  RentalRequestCreateResponseModel
  Future<ResponseModel<dynamic>> createRentalRequest(
      RentalRequestCreateModel request);
  Future<ResponseModel<int>> approveRentalRequest(int id);
  Future<ResponseModel<int>> declineRentalRequest(int id);
  Future<ResponseModel<RentalRequestByIdModel>> getRentalRequestById(int id);
  Future<ResponseModel<List<AllProcessTrackingModel>>> getAllProcessTracking();
  Future<ResponseModel<List<ProcessTrackingByIdModel>>>
      getDetailProcessTrackingByID({required int id});
}
