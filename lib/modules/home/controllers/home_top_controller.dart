import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_rent/core/model/account/Account.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'package:smart_rent/core/resources/auth_methods.dart';
import 'package:smart_rent/core/values/key_value.dart';
import 'package:crypto/crypto.dart';

class HomeTopWidgetController extends GetxController {
  late Account? currentAccount;
  final currentName = ''.obs;
  final currenLocation = ''.obs;
  final currenPhone = ''.obs;
  Location? crLocation;

  Future<void> getSharedPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    currentName.value =
        prefs.getString(KeyValue.KEY_ACCOUNT_USERNAME) ?? 'default';
    currenPhone.value = prefs.getString(KeyValue.KEY_ACCOUNT_PHONENUMBER) ?? '';
    currenLocation.value = prefs.getString(KeyValue.KEY_CURRENT_LOCATION) ??
        'Thành Phố Hồ Chí Minh';
    getName();
  }

  void getName() async {
    currentAccount = await AuthMethods.getUserDetails(
        FirebaseAuth.instance.currentUser!.uid);
    if (currentAccount != null) {
      currentName.value = currentAccount!.username;
    }
  }

  void getCurrentLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    locationData = await location.getLocation();
    final lat = locationData.latitude;
    final lon = locationData.longitude;

    // final url = Uri.parse(
    //     'https://maps.googleapis.com/maps/api/geocode/json?latlng=${locationData.latitude},${locationData.longitude}&key=${KeyValue.API_GOOGLE_MAP}');
    // final response = await http.get(url);
    // final resData = json.decode(response.body);
    // currenLocation.value = resData['results'][0]['formatted_address'];

    final url = Uri.parse(
        'https://api.geoapify.com/v1/geocode/reverse?lat=$lat&lon=$lon&apiKey=b10306886b84409faf35c32127d37095');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final result = json.decode(response.body);

      if (result["features"] != null && result["features"].isNotEmpty) {
        // Access the formatted value from the first feature
        final formattedValue = result['features'][0]['properties']['city'];
        currenLocation.value = formattedValue;
      } else {
        Get.snackbar("Error", 'Can' 't get location');
      }
    } else {
      Get.snackbar("Error", 'Can' 't get location');
    }
  }

  void getSign() {
    final orderCode = 123;
    final amount = 56000000;
    final description = "VQRIO123";
    final cancelUrl = "https://your-cancel-url.com";
    final returnUrl = "https://your-success-url.com";

    final data = {
      "orderCode": 123,
      "amount": 2000,
      "description": "VQRIO123",
      "buyerName": "Nguyen Van A",
      "buyerEmail": "buyer-email@gmail.com",
      "buyerPhone": "03733855259",
      "buyerAddress": "số nhà, đường, phường, tỉnh hoặc thành phố",
      "items": [
        {"name": "Iphone", "quantity": 2, "price": 28000000}
      ],
      "cancelUrl": "https://your-cancel-url.com",
      "returnUrl": "https://your-success-url.com",
      "expiredAt": 1696559798,
      "signature": "string"
    };

    final dulieu =
        'amount=$amount&cancelUrl=$cancelUrl&description=$description&orderCode=$orderCode&returnUrl=$returnUrl';

    var timestamp = DateTime(2023, 10, 28).millisecondsSinceEpoch ~/ 1000;
    data["expiredAt"] = timestamp;
    print(timestamp);

    // Tạo checksum key từ Kênh thanh toán
    final checksumKey =
        "f81731d89a73349606209191ba8e8fa20dd1bd5f2f96ea5ef3cd73e569dce6ef";

    // Tạo chuỗi dữ liệu cuối cùng để tạo chữ ký
    final finalDataString =
        "amount=$amount&cancelUrl=$cancelUrl&description=$description&orderCode=$orderCode&returnUrl=$returnUrl";

    // Tạo chữ ký bằng HMAC_SHA256
    final hmac = Hmac(sha256, utf8.encode(checksumKey));
    final signatureBytes = hmac.convert(utf8.encode(dulieu)).bytes;
    final signature = signatureBytes
        .map((byte) => byte.toRadixString(16).padLeft(2, '0'))
        .join();

    print("Chữ ký: $signature");
  }
}
