import 'package:flutter/material.dart';
import '/core/values/app_colors.dart';

class ButtonDetailTrackingRoom extends StatelessWidget {
  final String title;
  final Function() onTap;
  final double? width;
  final double? height;
  const ButtonDetailTrackingRoom({
    super.key,
    required this.title,
    required this.onTap,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 52,
      height: height ?? 24,
      decoration: BoxDecoration(
        color: primary80,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          splashColor: Colors.black.withOpacity(0.3),
          onTap: onTap,
          child: Container(
            child: Center(
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 10,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
