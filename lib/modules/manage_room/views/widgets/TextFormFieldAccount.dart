import 'package:flutter/material.dart';
import 'package:smart_rent/core/values/app_colors.dart';

class AccountButtonNav extends StatelessWidget {
  final String nameButton;
  final void Function() onPressed;
  final IconData firstIcon;

  const AccountButtonNav({
    super.key,
    required this.nameButton,
    required this.onPressed,
    required this.firstIcon,
  });
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: Icon(
        firstIcon,
        color: primary40,
      ),
      label: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            nameButton,
            textAlign: TextAlign.left,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: primary40,
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios,
            color: primary40,
          )
        ],
      ),
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        shadowColor: secondary80,
        //foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          // side: const BorderSide(
          //   color: secondary80,
          // ),
        ),
        fixedSize: const Size(
          double.infinity,
          56,
        ),
      ),
    );
  }
}
