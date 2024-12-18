
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/core/enums/utilities.dart';
import 'package:smart_rent/core/widget/view_image_dialog.dart';
import 'package:smart_rent/modules/post/post_controller.dart';
import 'package:smart_rent/modules/post/widgets/media_item_select.dart';


class UtilitiesPage extends StatefulWidget {
  const UtilitiesPage({super.key});

  @override
  State<UtilitiesPage> createState() => _UtilitiesPageState();
}

class _UtilitiesPageState extends State<UtilitiesPage> {
  final PostRoomController controller = Get.find<PostRoomController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Thông tin hình ảnh và tiện ích',
              style: TextStyle(
                  color: AppColors.primary40,
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 20,
            ),

            //---------------------Image-------------------------
            const Text(
              'HÌNH ẢNH',
              style: TextStyle(
                  color: AppColors.secondary40,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
                onTap: () async => controller.handleChooseImage(context),
                child: Obx(
                  () => DottedBorder(
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(10),
                    dashPattern: const [2, 2],
                    color: AppColors.secondary40,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      child: controller.pickedImages.value!.isEmpty
                          ? UploadInstruction()
                          : Column(
                              children: [
                                GridView.builder(
                                  shrinkWrap: true,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4,
                                    mainAxisSpacing: 8.0,
                                    crossAxisSpacing: 20.0,
                                  ),
                                  itemCount:
                                      controller.pickedImages.value?.length,
                                  itemBuilder: (context, index) {
                                    final XFile xFile = controller
                                        .pickedImages.value!
                                        .elementAt(index);

                                    return MediaItemSelect(
                                      index: index,
                                      xFile: xFile,
                                      onRemove: controller.onRemoveImage,
                                        onReview: (XFile xFile) {
                                          ViewImageDialog.show(
                                            url: xFile.path,
                                            isLocal: true,
                                          );
                                        }
                                    );
                                  },
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                const Text(
                                  'Đăng thêm hình ảnh',
                                  style: TextStyle(
                                      color: AppColors.primary40,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                    controller.validImageTotal.value
                                        ? '(Tối thiểu 4 ảnh, tối đa 20 ảnh)'
                                        : 'Vui lòng chọn tối thiểu 4 ảnh, tối đa 20 ảnh',
                                    style: TextStyle(
                                      color: controller.validImageTotal.value
                                          ? AppColors.secondary40
                                          : AppColors.red50,
                                      fontSize: 12,
                                    ))
                              ],
                            ),
                    ),
                  ),
                )),
            const SizedBox(
              height: 16,
            ),

            //---------------------Utilities-------------------------
            const Text(
              'TIỆN ÍCH',
              style: TextStyle(
                  color: AppColors.secondary40,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 10,
            ),
            Obx(
              () => GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 3,
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0,
                ),
                itemCount: controller.utilList.length,
                itemBuilder: (context, index) {
                  return FilledButton.icon(
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.all(0),
                      backgroundColor: controller.utilList[index].isChecked
                          ? AppColors.primary98
                          : AppColors.secondary90,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    onPressed: () {
                      controller.utilList[index] = controller.utilList[index]
                          .copyWith(
                              isChecked: !controller.utilList[index].isChecked);
                    },
                    icon: Icon(
                      controller.utilList[index].utility.getIconUtil,
                      size: 20,
                      color: controller.utilList[index].isChecked
                          ? AppColors.primary40
                          : AppColors.secondary40,
                    ),
                    label: Text(
                      controller.utilList[index].utility.getNameUtil,
                      style: TextStyle(
                          fontSize: 12,
                          color: controller.utilList[index].isChecked
                              ? AppColors.primary40
                              : AppColors.secondary40,
                          fontWeight: FontWeight.w500),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }

  Widget UploadInstruction() {
    return const Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Icon(
          Icons.add_photo_alternate_outlined,
          size: 52,
          color: AppColors.primary60,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          'Bấm vào đây để đăng hình ảnh nhé!',
          softWrap: true,
          maxLines: 2,
          style: TextStyle(
              color: AppColors.primary60,
              fontSize: 16,
              fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}


