import 'package:flutter/material.dart';

import '../../../../core/config/app_colors.dart';
import '/core/values/app_colors.dart';

class AccountButtonNav extends StatelessWidget {
  final String nameButton;
  final void Function() onPressed;
  final String firstIcon;

  const AccountButtonNav({
    super.key,
    required this.nameButton,
    required this.onPressed,
    required this.firstIcon,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        child: InkWell(
          onTap: onPressed,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset(
                    firstIcon,
                    width: 40,
                    height: 40,
                  ),
                  const Expanded(child: SizedBox()),
                  nameButton == "Hóa đơn hàng tháng"
                      ? Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                              color: AppColors.primary40,
                              borderRadius: BorderRadius.circular(100)),
                          child: const Text(
                            "Sắp ra mắt",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.w600),
                            textAlign: TextAlign.end,
                          ),
                        )
                      : const SizedBox()
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                nameButton,
                style: const TextStyle(
                    color: AppColors.secondary20,
                    fontWeight: FontWeight.w500,
                    fontSize: 14),
              )
            ],
          ),
        ));
  }
}
