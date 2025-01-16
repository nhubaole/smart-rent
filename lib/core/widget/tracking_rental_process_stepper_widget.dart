import 'package:flutter/material.dart';
import 'package:smart_rent/core/enums/tracking_rental_type.dart';
import 'package:smart_rent/core/model/rental_request/process_tracking_by_id_model.dart';
import 'package:smart_rent/core/widget/tracking_rental_process_stepper_item_widget.dart';

class TrackingRentalProcessStepperWidget extends StatelessWidget {
  final List<ProcessTrackingByIdModel> processTrackings;
  const TrackingRentalProcessStepperWidget(
      {super.key, required this.processTrackings});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: processTrackings.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final item = processTrackings[index];
        return TrackingRentalProcessStepperItemWidget(
          date: item.issuedAt ?? DateTime.now(),
          isStayedHere: false,
          isLast: index == processTrackings.length - 1,
          infoParner: item.actor?.fullName ?? '',
          type: TrackingRentalType.createdRentalContract,
        );
      },
    );
  }
}
