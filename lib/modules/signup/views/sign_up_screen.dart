import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:smart_rent/core/model/account/Account.dart';
import 'package:smart_rent/core/model/values/listProvinceVietNam.dart';
import 'package:smart_rent/core/values/app_colors.dart';
import 'package:smart_rent/core/widget/date_input_form_field.dart';
import 'package:smart_rent/core/widget/text_form_field_input.dart';
import 'package:smart_rent/modules/login/views/login_screen.dart';
import 'package:smart_rent/modules/signup/controlllers/sign_up_controllers.dart';
import 'package:smart_rent/modules/signup/controlllers/sign_up_verify_controller.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final signUpController = Get.put(SignUpController());
    final signUpVerifyController = Get.put(SignUpVerifyController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: SingleChildScrollView(
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
                key: signUpController.signUpFormKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormFieldInput(
                        textEditingController: signUpController.name,
                        labelText: 'Họ và tên',
                        hintText: 'Họ và tên (*)',
                        textInputType: TextInputType.text,
                        borderRadius: BorderRadius.circular(8),
                        borderWidth: 2,
                        borderColor: primary60,
                        icon: const Icon(Icons.phone_android),
                        onSaved: (newValue) {},
                        onValidate: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.length < 6) {
                            return 'Vui lòng nhập họ và tên';
                          }
                          return null;
                        },
                        autoCorrect: false,
                        textCapitalization: TextCapitalization.none,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormFieldInput(
                        maxLength: 10,
                        textEditingController: signUpController.phoneNumber,
                        labelText: 'Số điện thoại',
                        hintText: 'Số điện thoại (*)',
                        textInputType: TextInputType.phone,
                        borderRadius: BorderRadius.circular(8),
                        borderWidth: 2,
                        borderColor: primary60,
                        icon: const Icon(Icons.phone_android),
                        onSaved: (newValue) {},
                        onValidate: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.length < 10) {
                            return 'Vui lòng nhập số điện thoại';
                          }
                          return null;
                        },
                        autoCorrect: false,
                        textCapitalization: TextCapitalization.none,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      DateInputField(
                        firstDate: 1900,
                        lastDate: DateTime.now().year + 1,
                        borderRadius: BorderRadius.circular(8),
                        borderWidth: 2,
                        borderColor: primary60,
                        textEditingController: signUpController.dateOfBirth,
                        labelText: 'Ngày tháng năm sinh',
                        hintText: 'Ngày tháng năm sinh (*)',
                        icon: Icons.phone_android,
                        onDateSelected: (DateTime selectedDate) {
                          signUpController.dateOfBirth.text =
                              DateFormat('dd/MM/yyyy')
                                  .format(selectedDate)
                                  .toString();
                          signUpController.dateOfBirthCheck.value =
                              selectedDate;
                        },
                        onValidate: (value) {
                          if (!signUpController.isDate(value!)) {
                            return 'Vui lòng nhập ngày tháng năm sinh';
                          }
                          if (!signUpController.is18OrOlder(
                              signUpController.dateOfBirthCheck.value!)) {
                            return 'Bạn phải trên 18 tuổi';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      DropdownButtonFormField(
                        items: provinces
                            .map(
                              (e) => DropdownMenuItem(
                                value: e,
                                child: Text(e),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          signUpController.address.text = value.toString();
                        },
                        menuMaxHeight: MediaQuery.of(context).size.height * 0.4,
                        decoration: InputDecoration(
                          labelText: 'Tỉnh/Thành phố',
                          hintText: 'Tỉnh/Thành phố (*)',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: primary60,
                              width: 2,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: primary60,
                              width: 2,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: primary60,
                              width: 2,
                            ),
                          ),
                          prefixIcon: const Icon(
                            Icons.place_outlined,
                            color: primary60,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      RichText(
                        textAlign: TextAlign.center,
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text:
                                  'Bằng việc nhấn nút đăng ký, bạn đã đồng ý với các',
                              style: TextStyle(
                                color: secondary20,
                                fontSize: 14,
                              ),
                            ),
                            TextSpan(
                              text: 'Điều khoản dịch vụ và chính sách bảo mật',
                              style: TextStyle(
                                color: primary60,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Obx(
                        () => signUpController.isVerifying.value
                            ? const Center(
                                child: CircularProgressIndicator(
                                  backgroundColor: primary40,
                                  color: primary95,
                                ),
                              )
                            : GestureDetector(
                                onTap: () {
                                  if (signUpController
                                      .signUpFormKey.currentState!
                                      .validate()) {
                                    DateTime dateOfCreate = DateTime.now();
                                    String formattedDate =
                                        DateFormat('dd-MM-yyyy')
                                            .format(dateOfCreate);

                                    signUpController.account = Account(
                                      uid: '1',
                                      sex: true,
                                      age: 18,
                                      photoUrl:
                                          'https://images.unsplash.com/photo-1695239510467-f1e93d649c2b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2574&q=80',
                                      username:
                                          signUpController.name.text.trim(),
                                      phoneNumber: signUpController
                                          .phoneNumber.text
                                          .trim(),
                                      dateOfBirth: DateFormat('dd-MM-yyyy')
                                          .format(signUpController
                                              .dateOfBirthCheck.value!),
                                      address:
                                          signUpController.address.text.trim(),
                                      dateOfCreate: formattedDate,
                                    );
                                    signUpController
                                        .submit(signUpController.account);
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
                      ),
                      const SizedBox(
                        height: 30,
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
                            onPressed: () {
                              Get.to(
                                () => const LoginScreen(),
                              );
                            },
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
      ),
    );
  }
}
