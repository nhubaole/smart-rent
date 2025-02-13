import 'package:smart_rent/core/model/response/request_model.dart';
import 'package:smart_rent/core/model/return_request/return_request_by_id_model.dart';
import 'package:smart_rent/core/model/return_request/return_request_create_tenant_model.dart';

abstract class ReturnRequestRepo {
  Future<ResponseModel<ReturnRequestByIdModel>> getReturnRequestById(int id);
  Future<ResponseModel<bool>> confirmReturnRequest(int requestId);
  Future<ResponseModel<bool>> createReturnRequest(
      ReturnRequestCreateTenantModel model);
}
