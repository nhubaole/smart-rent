import 'package:get/get.dart';

class AccountEditController extends GetxController {
  final _name = ''.obs;
  final _email = ''.obs;
  final _phoneNumber = ''.obs;
  final _isLoading = false.obs;

  String get name => _name.value;
  String get email => _email.value;
  String get phoneNumber => _phoneNumber.value;
  bool get isLoading => _isLoading.value;

  set name(String value) => _name.value = value;
  set email(String value) => _email.value = value;
  set phoneNumber(String value) => _phoneNumber.value = value;
  set isLoading(bool value) => _isLoading.value = value;
}
