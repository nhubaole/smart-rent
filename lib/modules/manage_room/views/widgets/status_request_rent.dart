import 'package:flutter/material.dart';

import '../../../../core/config/app_colors.dart';
import '../../../../core/values/app_colors.dart';

class StatusRequestRent extends StatelessWidget {
  final int sumQuantityRequest;
  final Function() onTap;

  const StatusRequestRent({
    super.key,
    required this.sumQuantityRequest,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.grey.withOpacity(0.5),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.only(
            top: 20,
            right: 20,
            left: 20,
            bottom: 20,
          ),
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(
                color: AppColors.secondary80,
                width: 1,
              ),
            ),
          ),
          child: const Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Chưa xử lý',
                        style: TextStyle(
                          color: AppColors.primary40,
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Thời gian gửi: 8:30 04/12/2023',
                        style: TextStyle(
                          color: AppColors.secondary20,
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: AppColors.primary40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
