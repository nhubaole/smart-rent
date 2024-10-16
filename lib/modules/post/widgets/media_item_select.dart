import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_rent/core/config/app_colors.dart';

class MediaItemSelect extends StatelessWidget {
  const MediaItemSelect({
    super.key,
    required this.xFile,
    required this.index,
    required this.onRemove,
    this.onReview,
  });

  final XFile xFile;
  final int index;
  final Function(XFile xFile, int index) onRemove;
  final Function()? onReview;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: onReview,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            margin: const EdgeInsets.only(top: 4, right: 4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: AppColors.secondary80.withOpacity(0.4),
                width: 1,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(9),
              child: Image.file(
                File(xFile.path),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: InkWell(
            onTap: () => onRemove(xFile, index),
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: AppColors.secondary80,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.close,
                color: AppColors.secondary40,
                size: 16,
              ),
            ),
          ),
        )
      ],
    );
  }
}