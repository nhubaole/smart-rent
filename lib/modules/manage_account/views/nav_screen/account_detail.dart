import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_rent/core/values/app_colors.dart';
import 'package:smart_rent/modules/manage_account/controllers/nav_controller/account_detail_controller.dart';
import 'package:smart_rent/modules/manage_account/views/widget/TextFormFieldAccount.dart';

class AccountDetailScreen extends StatefulWidget {
  const AccountDetailScreen({super.key});

  @override
  State<AccountDetailScreen> createState() => _AccountDetailScreenState();
}

class _AccountDetailScreenState extends State<AccountDetailScreen> {
  final AccountDetailController detailController =
      Get.put(AccountDetailController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Thông tin cá nhân',
          style: TextStyle(
            color: primary40,
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.only(
            bottom: 30,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Obx(
                  () => detailController.isLoading.value
                      ? const LinearProgressIndicator(
                          color: primary95,
                        )
                      : const Padding(
                          padding: EdgeInsets.only(top: 0),
                        ),
                ),
                const SizedBox(
                  height: 16,
                ),
                PhotoAccount(detailController: detailController),
                const SizedBox(
                  height: 30,
                ),
                FormAccountDetail(
                  detailController: detailController,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FormAccountDetail extends StatelessWidget {
  const FormAccountDetail({
    super.key,
    required this.detailController,
  });

  final AccountDetailController detailController;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: detailController.formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Obx(
              () => TextFieldInput(
                textEditingController:
                    detailController.nameTextInputController.text == ''
                        ? TextEditingController(
                            text: detailController.currentName.value)
                        : detailController.nameTextInputController,
                labelText: 'Họ tên',
                hintText: 'Nhập họ tên',
                textInputType: TextInputType.text,
                borderRadius: BorderRadius.circular(10),
                borderWidth: 2,
                borderColor: Colors.transparent,
                onSaved: (p0) {
                  detailController.nameTextInputController.text = p0!;
                },
                onValidate: (p0) {},
                autoCorrect: false,
                textCapitalization: TextCapitalization.none,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(
                top: 20,
                right: 20,
                left: 32,
                bottom: 20,
              ),
              decoration: BoxDecoration(
                color: const Color(0xfff2f2f2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Số điện thoại',
                    style: TextStyle(
                      fontSize: 12,
                      color: secondary40,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Obx(
                    () => Text(
                      detailController.phoneNumber.value == ''
                          ? 'Chưa có số điện thoại'
                          : detailController.phoneNumber.value,
                      style: const TextStyle(
                        color: primary40,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                detailController.showProvinceSelectionDialog(context);
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.only(
                  top: 20,
                  right: 20,
                  left: 32,
                  bottom: 20,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xfff2f2f2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Địa chỉ',
                      style: TextStyle(
                        fontSize: 12,
                        color: secondary40,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Obx(
                      () => Text(
                        detailController.address.value == ''
                            ? 'Chưa có địa chỉ'
                            : detailController.address.value,
                        style: const TextStyle(
                          color: primary40,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: <Widget>[
                Flexible(
                  child: GestureDetector(
                    onTap: () {
                      detailController.showGenderDialog(context);
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(
                        top: 20,
                        right: 20,
                        left: 32,
                        bottom: 20,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xfff2f2f2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Giới tính',
                            style: TextStyle(
                              fontSize: 12,
                              color: secondary40,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Obx(
                            () => Text(
                              detailController.sex.value == ''
                                  ? 'Chưa có giới tính'
                                  : detailController.sex.value,
                              style: const TextStyle(
                                color: primary40,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(
                      top: 20,
                      right: 20,
                      left: 32,
                      bottom: 20,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xfff2f2f2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        detailController.selectDate(context);
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Năm sinh',
                            style: TextStyle(
                              fontSize: 12,
                              color: secondary40,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Obx(
                            () => Text(
                              detailController.dateOfBirth.value == ''
                                  ? 'Chưa có năm sinh'
                                  : detailController.dateOfBirth.value,
                              style: const TextStyle(
                                color: primary40,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () async {
                String res = await detailController.updateInfo();
                Get.snackbar('Notify', res);
              },
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100), color: primary60),
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Cập nhật',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PhotoAccount extends StatelessWidget {
  const PhotoAccount({
    super.key,
    required this.detailController,
  });

  final AccountDetailController detailController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 100,
      child: Stack(
        children: [
          Obx(
            () => CircleAvatar(
              radius: 64,
              backgroundImage: NetworkImage(
                detailController.photoUrl.value,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: InkWell(
              onTap: () {
                detailController.changeImage(context);
              },
              child: const CircleAvatar(
                radius: 16,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 14,
                  backgroundColor: Colors.blue,
                  child: Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}