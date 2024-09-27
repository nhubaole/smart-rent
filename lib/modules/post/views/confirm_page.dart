import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../core/config/app_colors.dart';
import '/modules/post/controllers/post_controller.dart';

class ConfirmPage extends StatefulWidget {
  const ConfirmPage({super.key});

  @override
  State<ConfirmPage> createState() => _ConfirmPageState();
}

class _ConfirmPageState extends State<ConfirmPage> {
  final PostController controller = Get.find<PostController>();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        width: double.infinity,
        child: Form(
          key: controller.formInfoKey,
          child: ListView(
            shrinkWrap: true,
            children: [
              const Text(
                'Xác nhận',
                style: TextStyle(
                    color: AppColors.primary40,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20,
              ),
              //---------------------Title-------------------------
              const Text(
                'TIÊU ĐỀ BÀI ĐĂNG',
                style: TextStyle(
                    color: AppColors.secondary40,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                validator: (value) => controller.fieldValidator(value!),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: controller.titleTextController,
                maxLength: 60,
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Nhập tiêu đề bài đăng',
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColors.primary40, width: 2)),
                ),
              ),
              const SizedBox(
                height: 16,
              ),

              //---------------------Title-------------------------
              const Text(
                'MÔ TẢ',
                style: TextStyle(
                    color: AppColors.secondary40,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                validator: (value) => controller.fieldValidator(value!),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: controller.descriptionTextController,
                keyboardType: TextInputType.multiline,
                maxLines: 4,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Môi trường sống sạch, khu phố an ninh,...',
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColors.primary40, width: 2)),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              const Text(
                'Nội quy phòng',
                style: TextStyle(
                    color: AppColors.secondary40,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                validator: (value) => controller.fieldValidator(value!),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: controller.regulationsTextController,
                keyboardType: TextInputType.multiline,
                maxLines: 4,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Nội quy phòng để đảm bảo quyền lợi đôi bên...',
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.primary40,
                      width: 2,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
