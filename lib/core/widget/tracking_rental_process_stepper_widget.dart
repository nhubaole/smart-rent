import 'package:flutter/material.dart';
import 'package:smart_rent/core/enums/tracking_rental_type.dart';
import 'package:smart_rent/core/widget/tracking_rental_process_stepper_item_widget.dart';

class TrackingRentalProcessStepperWidget extends StatelessWidget {
  const TrackingRentalProcessStepperWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return TrackingRentalProcessStepperItemWidget(
          date: DateTime.now(),
          isStayedHere: index % 2 == 0,
          isLast: index == 9,
          infoParner: 'Nguyễn Phương Phương',
          type: TrackingRentalType.createdRentalContract,
        );
      },
    );
  }
}
