import 'dart:convert';
import 'package:get/get.dart';
import 'package:smart_rent/core/model/account/Account.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'package:smart_rent/core/values/KEY_VALUE.dart';

class HomeTopWidgetController extends GetxController {
  Account? currentAccount;
  final _currentName = ''.obs;
  final _currenLocation = ''.obs;
  Location? crLocation;
  String get currentName => _currentName.value;
  String get currentLocation => _currenLocation.value;

  Future<void> getName() async {
    // String res = 'Something wrong';
    // try {
    //   currentAccount = await AuthMethods.instance.getUserDetails();
    //   if (currentAccount != null) {
    //     _currentName.value = currentAccount!.username;
    //     res = currentName;
    //   } else {
    //     res = 'error';
    //   }
    // } catch (error) {
    //   res = error.toString();
    // }
    // return res;
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
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${locationData.latitude},${locationData.longitude}&key=${KeyValue.API_GOOGLE_MAP}');
    final response = await http.get(url);
    final resData = json.decode(response.body);
    _currenLocation.value = resData['results'][0]['formatted_address'];
  }
}
