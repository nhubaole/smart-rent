import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_rent/core/model/account/Account.dart';
import 'package:smart_rent/core/model/room/room.dart';
import 'package:smart_rent/core/resources/auth_methods.dart';
import 'package:smart_rent/core/resources/firestore_methods.dart';
import 'package:smart_rent/core/resources/google_map_services.dart';
import 'package:smart_rent/core/values/KEY_VALUE.dart';

class HomeScreenController extends GetxController {
  var isScrollingUp = false.obs;
  late Account? currentAccount;
  final currentName = ''.obs;
  final currenLocation = ''.obs;
  final currenPhone = ''.obs;
  Location? crLocation;

  @override
  void onInit() {
    getSharedPreferences();
    getCurrentLocation();
    fetchDataAndConvertToList();
    getListRoom(false);
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

    Map<String, dynamic> currentLocationMap =
        await GoogleMapServices().convertLatLngToAddress(
      lat!,
      lon!,
      'vi',
    );
    currenLocation.value =
        currentLocationMap['results'][0]['formatted_address'];

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

    // final Map<String, dynamic> locationMap =
    //     await GeoApiFyServices().getCurrentLocation(lat, lon);
    // if (locationMap.isNotEmpty) {
    //   final formattedValue =
    //       locationMap['features'][0]['properties']['formatted'];

    //   currenLocation.value = formattedValue;
    // } else {
    //   Get.snackbar("Error", 'Can' 't get location');
    // }
  }

  // POPULAR CONTROLLER
  RxList<Map<String, dynamic>> dataList = <Map<String, dynamic>>[].obs;
  var isLoading = true.obs;

  void fetchDataAndConvertToList() {
    List<Map<String, dynamic>> fetchedData = [
      {
        'address': 'Quận 1',
        'photoUrl':
            'https://images.unsplash.com/photo-1696986293936-d8d080a88f50?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2671&q=80',
      },
      {
        'address': 'Quận 2',
        'photoUrl':
            'https://images.unsplash.com/photo-1695653422676-d9dd88400e21?ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2574&q=80',
      },
      {
        'address': 'Quận 3',
        'photoUrl':
            'https://images.unsplash.com/photo-1697044504071-12d33cc757cc?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2574&q=80',
      },
      {
        'address': 'Quận 1',
        'photoUrl':
            'https://images.unsplash.com/photo-1696986293936-d8d080a88f50?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2671&q=80',
      },
      {
        'address': 'Quận 2',
        'photoUrl':
            'https://images.unsplash.com/photo-1695653422676-d9dd88400e21?ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2574&q=80',
      },
      {
        'address': 'Quận 3',
        'photoUrl':
            'https://images.unsplash.com/photo-1697044504071-12d33cc757cc?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2574&q=80',
      },
      {
        'address': 'Quận 1',
        'photoUrl':
            'https://images.unsplash.com/photo-1696986293936-d8d080a88f50?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2671&q=80',
      },
      {
        'address': 'Quận 2',
        'photoUrl':
            'https://images.unsplash.com/photo-1695653422676-d9dd88400e21?ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2574&q=80',
      },
      {
        'address': 'Quận 3',
        'photoUrl':
            'https://images.unsplash.com/photo-1697044504071-12d33cc757cc?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2574&q=80',
      },
      {
        'address': 'Quận 1',
        'photoUrl':
            'https://images.unsplash.com/photo-1696986293936-d8d080a88f50?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2671&q=80',
      },
      {
        'address': 'Quận 2',
        'photoUrl':
            'https://images.unsplash.com/photo-1695653422676-d9dd88400e21?ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2574&q=80',
      },
      {
        'address': 'Quận 3',
        'photoUrl':
            'https://images.unsplash.com/photo-1697044504071-12d33cc757cc?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2574&q=80',
      },
    ];

    dataList.assignAll(fetchedData);
    isLoading.value = false;
  }

  // HOME LIST CONTROLLER
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  //var isLoading = Rx<bool>(false);
  var isLoadMore = Rx<bool>(false);
  var page = Rx<int>(10);
  var listRoom = Rx<List<Room>>([]);

  Future<void> getListRoom(bool isPagination) async {
    if (isPagination) {
      isLoadMore.value = true;
      listRoom.value =
          await FireStoreMethods().getListRoomForHome(page.value += 10);
      isLoadMore.value = false;
    } else {
      isLoading.value = true;
      listRoom.value = await FireStoreMethods().getListRoomForHome(page.value);
      isLoading.value = false;
    }
  }
}
