import 'package:flutter/material.dart';
import 'package:smart_rent/core/config/app_colors.dart';

class ItemHintAddress extends StatelessWidget {
  final Function() onPressed;
  final Function() onRemove;
  final String title;
  const ItemHintAddress({
    super.key,
    required this.onPressed,
    required this.onRemove,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(color: AppColors.secondary80, width: 1))),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(4),
          onTap: onPressed,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  color: AppColors.secondary40,
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                        color: AppColors.secondary20, fontSize: 14),
                    softWrap: true,
                  ),
                ),
                IconButton(
                  onPressed: onRemove,
                  icon: const Icon(
                    Icons.close,
                    color: AppColors.secondary20,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
