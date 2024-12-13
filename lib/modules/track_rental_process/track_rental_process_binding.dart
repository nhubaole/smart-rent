import 'package:get/get.dart';
import 'package:smart_rent/modules/track_rental_process/track_rental_process_controller.dart';

class TrackRentalProcessBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TrackRentalProcessController());
  }
}
