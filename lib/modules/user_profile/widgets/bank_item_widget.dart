import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/core/model/bank_model.dart';
import 'package:smart_rent/core/values/image_assets.dart';
import 'package:smart_rent/core/widget/cache_image_widget.dart';

class BankItemWidget extends StatelessWidget {
  const BankItemWidget({
    super.key,
    required this.onSelected,
    required this.bank,
  });

  final Function(BankModel bank) onSelected;
  final BankModel bank;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: AppColors.secondary40.withOpacity(0.2),
        onTap: () => onSelected(bank),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8.px, horizontal: 8.px),
          child: Row(
            children: [
              ClipOval(
                child: CacheImageWidget(
                  imageUrl: bank.logo ?? ImageAssets.demo,
                  width: 50.px,
                  height: 50.px,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(width: 8.px),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: AppColors.secondary20,
                        fontWeight: FontWeight.w600,
                      ),
                      TextSpan(text: bank.bankCode!),
                    ),
                    Text.rich(
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.secondary40,
                        fontWeight: FontWeight.w400,
                      ),
                      TextSpan(text: bank.bankName!),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
