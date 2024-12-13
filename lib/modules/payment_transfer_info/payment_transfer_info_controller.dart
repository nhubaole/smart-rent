import 'package:get/get.dart';
import 'package:smart_rent/core/routes/app_routes.dart';
import 'package:smart_rent/modules/payment_transfer_info/widgets/upload_evidence_banking_sheet.dart';

class PaymentTransferInfoController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  onOpenUploadEvidenceSheet() {
    Get.bottomSheet(
      isScrollControlled: true,
      isDismissible: true,
      UploadEvidenceBankingSheet(
        onSave: () => Get.toNamed(AppRoutes.paymentSuccess),
      ),
    );
  }
}
