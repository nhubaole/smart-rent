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
    if (status == 'success') {
      backgroundColor = const Color(0xffE9FFE8);
      textColor = const Color(0xFF3FA836);
    } else if (status == 'progress') {
      backgroundColor = Colors.grey;
      textColor = Colors.white;
    } else if (status == 'fail') {
      backgroundColor = Colors.red;
      textColor = Colors.white;
    }
    return Center(
      child: Container(
        width: 103,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: backgroundColor,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              status,
              style: TextStyle(
                fontSize: 15,
                color: textColor,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
