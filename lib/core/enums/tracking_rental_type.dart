import 'package:get/get.dart';

enum TrackingRentalType {
  rentalProcessCompleted,
  singedContractAndPaidDeposit,
  createdRentalContract,
  processedRentalRequest,
  sentRentalRequest,
  paidInvoice,
  sentInvoice,
  rentalContractReady,
}

extension TrackingRentalTypeExtension on TrackingRentalType {
  String get name {
    switch (this) {
      case TrackingRentalType.rentalProcessCompleted:
        return 'rental_process_completed'.tr;
      case TrackingRentalType.singedContractAndPaidDeposit:
        return 'signed_contract_and_paid_deposit'.tr;
      case TrackingRentalType.createdRentalContract:
        return 'created_rental_contract'.tr;
      case TrackingRentalType.processedRentalRequest:
        return 'processed_rental_request'.tr;
      case TrackingRentalType.sentRentalRequest:
        return 'sent_rental_request'.tr;
      case TrackingRentalType.paidInvoice:
        return 'paid_invoice'.tr;
      case TrackingRentalType.sentInvoice:
        return 'sent_invoice'.tr;
      case TrackingRentalType.rentalContractReady:
        return 'rental_contract_ready'.tr;
    }
  }
}
