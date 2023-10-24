import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_rent/core/model/account/Account.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'package:smart_rent/core/values/key_value.dart';

class HomeTopWidgetController extends GetxController {
  Account? currentAccount;
  final currentName = ''.obs;
  final currenLocation = ''.obs;
  Location? crLocation;

  Future<void> getSharedPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    currentName.value =
        prefs.getString(KeyValue.KEY_ACCOUNT_USERNAME) ?? 'default';
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
}
