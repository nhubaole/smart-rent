import 'package:get/get.dart';
import 'package:smart_rent/modules/transaction_history/transaction_history_controller.dart';

class TransactionHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TransactionHistoryController());
  }
}
