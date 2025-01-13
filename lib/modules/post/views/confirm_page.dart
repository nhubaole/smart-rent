import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/core/widget/outline_text_filed_widget.dart';
import 'package:smart_rent/modules/post/post_controller.dart';

class ConfirmPage extends StatefulWidget {
  const ConfirmPage({super.key});

  @override
  State<ConfirmPage> createState() => _ConfirmPageState();
}

class _ConfirmPageState extends State<ConfirmPage> {
  final PostRoomController controller = Get.find<PostRoomController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      width: double.infinity,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Form(
          key: controller.formKeyConfirm,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Xác nhận',
                style: TextStyle(
                    color: AppColors.primary40,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 20.px),
              //---------------------Title-------------------------
              const Text(
                'TIÊU ĐỀ BÀI ĐĂNG',
                style: TextStyle(
                    color: AppColors.secondary40,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 10.px),
              // TextFormField(
              //   validator: (value) => controller.fieldValidator(value!),
              //   autovalidateMode: AutovalidateMode.onUserInteraction,
              //   controller: controller.titleTextController,
              //   maxLength: 60,
              //   maxLengthEnforcement: MaxLengthEnforcement.enforced,
              //   decoration: const InputDecoration(
              //     border: OutlineInputBorder(),
              //     hintText: 'Nhập tiêu đề bài đăng',
              //     focusedBorder: OutlineInputBorder(
              //         borderSide:
              //             BorderSide(color: AppColors.primary40, width: 2)),
              //   ),
              // ),
              OutlineTextFiledWidget(
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                maxLength: 60,
                textEditingController: controller.titleTextController,
                textInputType: TextInputType.numberWithOptions(
                    decimal: true, signed: true),
                hintText: 'Nhập tiêu đề bài đăng',
                onValidate: (p0) {
                  if (p0 == null || p0.isEmpty) {
                    return 'Vui lòng nhập tiêu đề bài đăng';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.px),

              //---------------------Title-------------------------
              const Text(
                'MÔ TẢ',
                style: TextStyle(
                    color: AppColors.secondary40,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 10.px),
              // TextFormField(
              //   validator: (value) => controller.fieldValidator(value!),
              //   autovalidateMode: AutovalidateMode.onUserInteraction,
              //   controller: controller.descriptionTextController,
              //   keyboardType: TextInputType.multiline,
              //   maxLines: 4,
              //   decoration: const InputDecoration(
              //     border: OutlineInputBorder(),
              //     hintText: 'Môi trường sống sạch, khu phố an ninh,...',
              //     focusedBorder: OutlineInputBorder(
              //         borderSide:
              //             BorderSide(color: AppColors.primary40, width: 2)),
              //   ),
              // ),
              OutlineTextFiledWidget(
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                maxlines: 4,
                textEditingController: controller.descriptionTextController,
                textInputType: TextInputType.numberWithOptions(
                    decimal: true, signed: true),
                hintText: 'Môi trường sống sạch, khu phố an ninh,...',
                onValidate: (p0) {
                  if (p0 == null || p0.isEmpty) {
                    return 'Vui lòng nhập mô tả';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.px),
              const Text(
                'Nội quy phòng',
                style: TextStyle(
                    color: AppColors.secondary40,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 10.px),
              // TextFormField(
              //   validator: (value) => controller.fieldValidator(value!),
              //   autovalidateMode: AutovalidateMode.onUserInteraction,
              //   controller: controller.regulationsTextController,
              //   keyboardType: TextInputType.multiline,
              //   maxLines: 4,
              //   decoration: const InputDecoration(
              //     border: OutlineInputBorder(),
              //     hintText: 'Nội quy phòng để đảm bảo quyền lợi đôi bên...',
              //     focusedBorder: OutlineInputBorder(
              //       borderSide: BorderSide(
              //         color: AppColors.primary40,
              //         width: 2,
              //       ),
              //     ),
              //   ),
              // ),
              OutlineTextFiledWidget(
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                maxlines: 4,
                textEditingController: controller.regulationsTextController,
                textInputType: TextInputType.numberWithOptions(
                    decimal: true, signed: true),
                hintText: 'Nội quy phòng để đảm bảo quyền lợi đôi bên...',
                onValidate: (p0) {
                  if (p0 == null || p0.isEmpty) {
                    return 'Vui lòng nhập nội quy phòng';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.px),
            ],
          ),
        ),
      ),
    );
  }
}
