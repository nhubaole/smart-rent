import 'package:flutter/material.dart';

class StatusWidget extends StatelessWidget {
  final String status;

  const StatusWidget({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Colors.green;
    Color textColor = Colors.white;
    String viStatus = 'Thành công';
    if (status == 'success') {
      backgroundColor = const Color(0xffE9FFE8);
      textColor = const Color(0xFF3FA836);
      viStatus = 'Thành công';
    } else if (status == 'progress') {
      backgroundColor = Colors.grey;
      viStatus = 'Đang chờ...';
      textColor = Colors.white;
    } else if (status == 'fail') {
      backgroundColor = Colors.red;
      textColor = Colors.white;
      viStatus = 'Hết thời gian giờ';
    }
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.01),
        height: MediaQuery.of(context).size.height * 0.045,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: backgroundColor,
        ),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            viStatus,
            style: TextStyle(
              fontSize: 15,
              color: textColor,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
