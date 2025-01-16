import 'package:smart_rent/core/model/billing/bill_by_id_model.dart';
import 'package:smart_rent/core/model/billing/bill_by_month_and_user_model.dart';
import 'package:smart_rent/core/model/billing/bill_by_status_model.dart';
import 'package:smart_rent/core/model/billing/billing_all_metric_model.dart';
import 'package:smart_rent/core/model/billing/billing_create_index_request_model.dart';
import 'package:smart_rent/core/model/billing/billing_create_index_response.dart';
import 'package:smart_rent/core/model/billing/billing_list_index_by_landlord_model.dart';
import 'package:smart_rent/core/model/response/request_model.dart';

abstract class BillingRepo {
  Future<ResponseModel<List<BillByMonthAndUserModel>>> getBillByMonthAndUser({
    required int month,
    required int year,
  });

  Future<ResponseModel<BillByIdModel>> getBillByID({
    required int billID,
  });

  Future<ResponseModel<BillingAllMetricModel>> getBillAllMetric({
    required int roomID,
    required int month,
    required int year,
  });

  Future<ResponseModel<List<BillByStatusModel>>> getBillByStatus({
    required int status,
  });
  
  Future<ResponseModel<List<BillingListIndexByLandlordModel>>>
      getBillListIndexByLandlord({
    required int month,
    required int year,
    required bool isWater,
  });

  Future<ResponseModel<BillingCreateIndexResponse>> createIndex({
    required BillingCreateIndexRequestModel request,
  });

}
