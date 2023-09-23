import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_rent/core/model/account/Account.dart';
import 'package:smart_rent/core/resources/firestore_methods.dart';
import 'package:smart_rent/core/values/app_colors.dart';
import 'package:smart_rent/core/widget/dialog_custom.dart';
import 'package:smart_rent/core/widget/dialog_otp.dart';
import 'package:smart_rent/core/widget/text_form_field_input.dart';
import 'package:smart_rent/modules/signup/controlllers/sign_up_controllers.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({
    super.key,
  });

  @override
  State<SignUpScreen> createState() => _SignScreenState();
}

class _SignScreenState extends State<SignUpScreen> {
  late Account account;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Tạo tài khoản mới',
              style: TextStyle(
                color: primary10,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            const Text(
              'Đăng ký ngay hôm nay để tìm được\n phòng trọ ưng ý',
              style: TextStyle(
                color: secondary40,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 16,
            ),
            Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormFieldInput(
                      maxLength: 50,
                      textEditingController: controller.name,
                      labelText: 'Họ và tên',
                      hintText: 'Họ và tên (*)',
                      textInputType: TextInputType.text,
                      borderRadius: BorderRadius.circular(8),
                      borderWidth: 2,
                      borderColor: primary60,
                      icon: const Icon(Icons.phone_android),
                      onSaved: (newValue) {},
                      onValidate: (value) {
                        return null;
                      },
                      autoCorrect: false,
                      textCapitalization: TextCapitalization.none,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    TextFormFieldInput(
                      maxLength: 10,
                      textEditingController: controller.phoneNumber,
                      labelText: 'Số điện thoại',
                      hintText: 'Số điện thoại (*)',
                      textInputType: TextInputType.phone,
                      borderRadius: BorderRadius.circular(8),
                      borderWidth: 2,
                      borderColor: primary60,
                      icon: const Icon(Icons.phone_android),
                      onSaved: (newValue) {},
                      onValidate: (value) {
                        if (value!.isEmpty || value.length < 10) {
                          return 'Vui lòng nhập số điện thoại';
                        }
                        return null;
                      },
                      autoCorrect: false,
                      textCapitalization: TextCapitalization.none,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    TextFormFieldInput(
                      maxLength: 10,
                      textEditingController: controller.dateOfBirth,
                      labelText: 'Ngày tháng năm sinh',
                      hintText: 'Ngày tháng năm sinh (*)',
                      textInputType: TextInputType.text,
                      borderRadius: BorderRadius.circular(8),
                      borderWidth: 2,
                      borderColor: primary60,
                      icon: const Icon(Icons.phone_android),
                      onSaved: (newValue) {},
                      onValidate: (value) {
                        return null;
                      },
                      autoCorrect: false,
                      textCapitalization: TextCapitalization.none,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    TextFormFieldInput(
                      maxLength: 50,
                      textEditingController: controller.address,
                      labelText: 'Địa chỉ hiện tại',
                      hintText: 'Địa chỉ hiện tại (*)',
                      textInputType: TextInputType.text,
                      borderRadius: BorderRadius.circular(8),
                      borderWidth: 2,
                      borderColor: primary60,
                      icon: const Icon(Icons.phone_android),
                      onSaved: (newValue) {},
                      onValidate: (value) {
                        return null;
                      },
                      autoCorrect: false,
                      textCapitalization: TextCapitalization.none,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    GestureDetector(
                      onTap: () {
                        try {
                          if (formKey.currentState!.validate()) {
                            SignUpController.instance.phoneAuthentication(
                                controller.phoneNumber.text.trim());
                            account = Account(
                              uid: '1',
                              sex: true,
                              age: 18,
                              photoUrl:
                                  'https://images.unsplash.com/photo-1695239510467-f1e93d649c2b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2574&q=80',
                              username: controller.name.text.trim(),
                              phoneNumber: controller.phoneNumber.text.trim(),
                              dateOfBirth: DateTime.now(),
                              address: controller.address.text.trim(),
                            );

                            Get.dialog(
                              DialogOTP(
                                onPressed: () {},
                                backgroundColor: primary60,
                                phoneNumber: controller.phoneNumber.text.trim(),
                                user: account,
                              ),
                            );
                          }
                        } catch (e) {
                          Get.snackbar('Lỗi', e.toString());
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: primary60),
                        child: const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            'Đăng ký ngay',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Bạn đã có tài khoản?',
                          style: TextStyle(
                            color: secondary40,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Đăng nhập ngay',
                            style: TextStyle(color: primary60),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
