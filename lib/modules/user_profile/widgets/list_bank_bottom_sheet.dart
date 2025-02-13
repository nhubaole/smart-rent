import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/core/model/bank_model.dart';
import 'package:smart_rent/modules/user_profile/widgets/bank_item_widget.dart';

class ListBankBottomSheet extends StatefulWidget {
  final List<BankModel> banks;
  final Function(BankModel) onSelected;
  const ListBankBottomSheet({
    super.key,
    required this.banks,
    required this.onSelected,
  });

  @override
  ListBankBottomSheetState createState() => ListBankBottomSheetState();
}

class ListBankBottomSheetState extends State<ListBankBottomSheet> {
  final ValueNotifier<String> _searchQuery = ValueNotifier<String>('');

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: EdgeInsets.only(
          top: 10.px,
          right: 16.px,
          left: 16.px,
          bottom: 16.px,
        ),
        constraints: BoxConstraints(minHeight: Get.height / 3),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.px),
            topRight: Radius.circular(20.px),
          ),
        ),
        child: Column(
          children: [
            _buildHeader(),
            SizedBox(height: 16.px),
            _buildSearch(),
            _buildListBank(),
          ],
        ),
      ),
    );
  }

  Expanded _buildListBank() {
    return Expanded(
      child: ValueListenableBuilder<String>(
        valueListenable: _searchQuery,
        builder: (context, query, _) {
          final filteredBanks = widget.banks.where((bank) {
            final bankNameMatches =
                bank.bankName?.toLowerCase().contains(query.toLowerCase()) ??
                    false;
            final bankCodeMatches =
                bank.bankCode?.toLowerCase().contains(query.toLowerCase()) ??
                    false;
            return bankNameMatches || bankCodeMatches;
          }).toList();
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 16.px),
            physics: const BouncingScrollPhysics(),
            child: ListView.separated(
              separatorBuilder: (context, index) => Divider(
                color: AppColors.secondary80,
                height: 0.5.px,
              ),
              itemCount: filteredBanks.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final bank = filteredBanks[index];
                return BankItemWidget(
                  onSelected: (bank) {
                    FocusManager.instance.primaryFocus?.unfocus();
                    widget.onSelected(bank);
                    Get.back();
                  },
                  bank: bank,
                );
              },
            ),
          );
        },
      ),
    );
  }

  Container _buildSearch() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.secondary90,
        borderRadius: BorderRadius.circular(8.px),
      ),
      child: TextFormField(
        style: TextStyle(
          fontSize: 16.sp,
          color: AppColors.secondary20,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          hintText: 'Tìm kiếm ngân hàng',
          prefixIcon: Icon(Icons.search),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 16.px),
        ),
        onChanged: (value) {
          _searchQuery.value = value;
        },
      ),
    );
  }

  Row _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Chọn ngân hàng'.tr,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        IconButton(
          onPressed: () {
            FocusManager.instance.primaryFocus?.unfocus();
            Get.isBottomSheetOpen! ? Get.back() : null;
          },
          icon: const Icon(
            Icons.close,
            color: AppColors.secondary20,
          ),
        ),
      ],
    );
  }
}
