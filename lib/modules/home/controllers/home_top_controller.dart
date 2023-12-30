import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_rent/core/model/account/Account.dart';
import 'package:location/location.dart';
import 'package:smart_rent/core/resources/auth_methods.dart';
import 'package:smart_rent/core/resources/geoapify_services.dart';
import 'package:smart_rent/core/values/key_value.dart';

class HomeTopWidgetController extends GetxController {
  late Account? currentAccount;
  final currentName = ''.obs;
  final currenLocation = ''.obs;
  final currenPhone = ''.obs;
  Location? crLocation;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> getSharedPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    currentName.value =
        prefs.getString(KeyValue.KEY_ACCOUNT_USERNAME) ?? 'default';
    currenPhone.value = prefs.getString(KeyValue.KEY_ACCOUNT_PHONENUMBER) ?? '';

    getName();
  }

  void getName() async {
    currentAccount = await AuthMethods.getUserDetails(
        FirebaseAuth.instance.currentUser!.uid);
    if (currentAccount != null) {
      currentName.value = currentAccount!.username;
    }
  }

  Future<void> getCurrentLocation() async {
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
    // final url = Uri.parse(
    //     '${dotenv.env['geoapify_url']}/geocode/reverse?lat=$lat&lon=$lon&apiKey=${dotenv.env['geoapify_url_api']}');

    // final response = await http.get(url);

    // if (response.statusCode == 200) {
    //   final result = json.decode(response.body);

    //   if (result["features"] != null && result["features"].isNotEmpty) {
    //     final formattedValue = result['features'][0]['properties']['formatted'];
    //     currenLocation.value = formattedValue;
    //   } else {
    //     Get.snackbar("Error", 'Can' 't get location');
    //   }
    // } else {
    //   Get.snackbar("Error", 'Can' 't get location');
    // }

    final Map<String, dynamic> locationMap =
        await GeoApiFyServices().getCurrentLocation(lat, lon);
    if (locationMap.isNotEmpty) {
      final formattedValue =
          locationMap['features'][0]['properties']['formatted'];

      currenLocation.value = formattedValue;
    } else {
      Get.snackbar("Error", 'Can' 't get location');
    }
  }
}
