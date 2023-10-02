import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:smart_rent/core/model/account/Account.dart';
import 'package:smart_rent/core/model/values/listProvinceVietNam.dart';
import 'package:smart_rent/core/resources/auth_methods.dart';
import 'package:smart_rent/core/values/app_colors.dart';
import 'package:smart_rent/core/widget/date_input_form_field.dart';
import 'package:smart_rent/core/widget/dialog_custom.dart';
import 'package:smart_rent/core/widget/dialog_otp.dart';
import 'package:smart_rent/core/widget/text_form_field_input.dart';
import 'package:smart_rent/modules/login/views/login_screen.dart';
import 'package:smart_rent/modules/signup/controlllers/sign_up_controllers.dart';
import 'package:smart_rent/modules/signup/controlllers/sign_up_verify_controller.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({
    super.key,
  });

  @override
  State<SignUpScreen> createState() => _SignScreenState();
}

class _SignScreenState extends State<SignUpScreen> {
  late Account account;
  final controller = Get.put(SignUpController());

  final _formKey = GlobalKey<FormState>();
  var dateOfBirth;

  void submit(Account account) async {
    try {
      String resQuery = await SignUpController.instance
          .checkExistPhoneNumber(account.phoneNumber);

      if (resQuery != 'success') {
        Get.dialog(
          DialogCustom(
              onPressed: () {
                Get.to(() => const LoginScreen());
              },
              backgroundColor: Colors.white,
              iconPath: 'assets/images/ic_notify.png',
              title: 'Thông báo',
              subTitle:
                  'Đã tồn tại tài khoản với số điện thoại này, đăng nhập ngay'),
        );
      } else {
        final AuthenController = Get.lazyPut(() => AuthMethods());
        SignUpController.instance.phoneAuthentication(account.phoneNumber);

        Get.dialog(
          DialogOTP(
            onPressed: () {},
            backgroundColor: primary60,
            phoneNumber: account.phoneNumber,
            user: account,
          ),
        );
      }
    } catch (e) {
      Get.snackbar('Lỗi', e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    controller.dateOfBirth.text =
        DateFormat('dd/MM/yyyy').format(DateTime.now()).toString();
    dateOfBirth = DateTime.now();
    Get.put(SignUpVerifyController());
  }

  @override
  Widget build(BuildContext context) {
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
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormFieldInput(
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
                        textEditingController: controller.dateOfBirth,
                        labelText: 'Ngày tháng năm sinh',
                        hintText: 'Ngày tháng năm sinh (*)',
                        icon: Icons.phone_android,
                        onDateSelected: (DateTime selectedDate) {
                          controller.dateOfBirth.text = DateFormat('dd/MM/yyyy')
                              .format(selectedDate)
                              .toString();
                          dateOfBirth = selectedDate;
                        },
                        onValidate: (value) {
                          if (!SignUpController.instance.isDate(value!)) {
                            return 'Vui lòng nhập ngày tháng năm sinh';
                          }
                          if (!SignUpController.instance
                              .is18OrOlder(dateOfBirth)) {
                            return 'Bạn phải trên 18 tuổi';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      // TextFormFieldInput(
                      //   textEditingController: controller.address,
                      //   labelText: 'Địa chỉ hiện tại',
                      //   hintText: 'Địa chỉ hiện tại (*)',
                      //   textInputType: TextInputType.text,
                      //   borderRadius: BorderRadius.circular(8),
                      //   borderWidth: 2,
                      //   borderColor: primary60,
                      //   icon: const Icon(Icons.phone_android),
                      //   onSaved: (newValue) {},
                      //   onValidate: (value) {
                      //     if (value == null ||
                      //         value.isEmpty ||
                      //         !provinces.contains(value.trim())) {
                      //       return 'Vui lòng nhập địa chỉ';
                      //     }

                      //     return null;
                      //   },
                      //   autoCorrect: false,
                      //   textCapitalization: TextCapitalization.none,
                      // ),

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
                          controller.address.text = value.toString();
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
                      GestureDetector(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            account = Account(
                              uid: '1',
                              sex: true,
                              age: 18,
                              photoUrl:
                                  'https://images.unsplash.com/photo-1695239510467-f1e93d649c2b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2574&q=80',
                              username: controller.name.text.trim(),
                              phoneNumber: controller.phoneNumber.text.trim(),
                              dateOfBirth: dateOfBirth,
                              address: controller.address.text.trim(),
                              dateOfCreate: DateTime.now(),
                            );
                            submit(account);
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
