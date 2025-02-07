import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/core/widget/outline_text_filed_widget.dart';
import 'package:smart_rent/modules/contract_creation/contract_creation_controller.dart';

class ContractCreationPartPolicy extends GetView<ContractCreationController> {
  const ContractCreationPartPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.only(
          right: 16.px,
          left: 16.px,
          bottom: MediaQuery.of(context).viewInsets.bottom + 10.px),
      child: Column(
        children: [
          _buildHeader(),
          SizedBox(height: 16.px),
          Obx(() => _buildPrivateForPartner(
                partner: 'landlord_responsibility'.tr,
                onChanged: (value) {
                  controller.useSystemTemplateA.value = value ?? false;
                  controller.responsibilityAController.text = value == true
                      ? "- Tạo mọi điều kiện thuận lợi để bên B thực hiện theo hợp đồng.\n - Cung cấp nguồn điện, nước, wifi cho bên B sử dụng."
                      : "";
                },
                value: controller.useSystemTemplateA.value,
                textEditingController: controller.responsibilityAController,
                onValidate: (value) => null,
              )),
          SizedBox(height: 16.px),
          Obx(() => _buildPrivateForPartner(
                partner: 'tenant_responsibility'.tr,
                onChanged: (value) {
                  controller.useSystemTemplateB.value = value ?? false;
                  controller.responsibilityBController.text = value == true
                      ? "- Thanh toán đầy đủ các khoản tiền theo đúng thỏa thuận.\n- Bảo quản các trang thiết bị và cơ sở vật chất của bên A trang bị cho ban đầu (làm hỏng phải sửa, mất phải đền).\n- Không được tự ý sửa chữa, cải tạo cơ sở vật chất khi chưa được sự đồng ý của bên A.\n- Giữ gìn vệ sinh trong và ngoài khuôn viên của phòng trọ.\n- Bên B phải chấp hành mọi quy định của pháp luật Nhà nước và quy định của địa phương.\n- Nếu bên B cho khách ở qua đêm thì phải báo và được sự đồng ý của chủ nhà đồng thời phải chịu trách nhiệm về các hành vi vi phạm pháp luật của khách trong thời gian ở lại."
                      : "";
                },
                value: controller.useSystemTemplateB.value,
                textEditingController: controller.responsibilityBController,
                onValidate: (value) => null,
              )),
          SizedBox(height: 16.px),
          Obx(() => _buildPrivateForPartner(
                partner: 'joint_responsibility'.tr,
                onChanged: (value) {
                  controller.useSystemTemplateGeneral.value = value ?? false;
                  controller.generalResponsibilityController.text = value ==
                          true
                      ? "- Hai bên phải tạo điều kiện cho nhau thực hiện hợp đồng.\n- Trong thời gian hợp đồng còn hiệu lực nếu bên nào vi phạm các điều khoản đã thỏa thuận thì bên còn lại có quyền đơn phương chấm dứt hợp đồng; nếu sự vi phạm hợp đồng đó gây tổn thất cho bên bị vi phạm hợp đồng thì bên vi phạm hợp đồng phải bồi thường thiệt hại.\n- Một trong hai bên muốn chấm dứt hợp đồng trước thời hạn thì phải báo trước cho bên kia ít nhất 30 ngày và hai bên phải có sự thống nhất.\n- Bên A phải trả lại tiền đặt cọc cho bên B.\n- Bên nào vi phạm điều khoản chung thì phải chịu trách nhiệm trước pháp luật.\n- Hợp đồng được lập thành 02 bản có giá trị pháp lý như nhau, mỗi bên giữ một bản."
                      : "";
                },
                value: controller.useSystemTemplateGeneral.value,
                textEditingController:
                    controller.generalResponsibilityController,
                onValidate: (value) => null,
              )),
          SizedBox(height: 16.px),
        ],
      ),
    );
  }

  Column _buildPrivateForPartner({
    required String partner,
    required Function(bool?)? onChanged,
    required bool value,
    required TextEditingController textEditingController,
    required String? Function(String?)? onValidate,
    int minlines = 5,
  }) {
    return Column(
      children: [
        _buildResponsibilityPartner(partner),
        SizedBox(height: 4.px),
        InkWell(
          borderRadius: BorderRadius.circular(20.px),
          onTap: () {
            onChanged?.call(!value);
          },
          child: Row(
            children: [
              Checkbox(
                value: value,
                onChanged: onChanged,
                activeColor: AppColors.primary40,
              ),
              Text(
                'use_system_template'.tr,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.normal,
                  color: AppColors.secondary20,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 4.px),
        OutlineTextFiledWidget(
          textEditingController: textEditingController,
          onValidate: onValidate,
          minlines: minlines,
        ),
      ],
    );
  }

  Align _buildResponsibilityPartner(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16.sp,
          color: AppColors.secondary40,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Align _buildHeader() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        'responsibilities'.tr,
        style: TextStyle(
          color: AppColors.primary40,
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
