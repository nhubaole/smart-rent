import 'package:flutter/material.dart';
import 'package:smart_rent/core/values/app_colors.dart';

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
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 4,
              offset: Offset(0, 2), // changes position of shadow
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
                    width: 50,
                    height: 50,
                  ),
                  Expanded(child: SizedBox()),
                  nameButton ==  "Hóa đơn hàng tháng" ? Container(
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                        color: primary40,
                        borderRadius: BorderRadius.circular(100)),
                    child: Text(
                      "Sắp ra mắt",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600),
                      textAlign: TextAlign.end,
                    ),
                  ) : SizedBox()
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                nameButton,
                style: TextStyle(
                    color: secondary20,
                    fontWeight: FontWeight.w500,
                    fontSize: 14),
              )
            ],
          ),
        ));
  }
}
