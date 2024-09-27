import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_rent/core/enums/room_fetch.dart';
import 'package:smart_rent/core/repositories/room/room_repo_impl.dart';
import '/core/model/room/room.dart';
import '/core/resources/google_map_services.dart';
import '/core/values/KEY_VALUE.dart';

class HomeScreenController extends GetxController {
  var isScrollingUp = false.obs;
  final currentName = ''.obs;
  final currenLocation = ''.obs;
  final currenPhone = ''.obs;
  Location? crLocation;
  var isLoading = true.obs;
  var isFetchingRoom = RoomFetch.LOADING.obs;
  var isLoadingMap = Rx<bool>(true);
  final currencyFormat = NumberFormat.currency(locale: 'vi_VN', symbol: '');

  @override
  void onInit() async {
    getSharedPreferences();

    fetchDataAndConvertToList();
    getListRoom(false);
    await getCurrentLocation();
    super.onInit();
  }

  Future<void> getSharedPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    currentName.value =
        prefs.getString(KeyValue.KEY_ACCOUNT_USERNAME) ?? 'default';
    currenPhone.value = prefs.getString(KeyValue.KEY_ACCOUNT_PHONENUMBER) ?? '';
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

    List<String> areas = currentLocationMap['results'][0]['formatted_address']
        .toString()
        .split(',');
    await getListRoomByListSplit(areas);
  }

  // POPULAR CONTROLLER
  RxList<Map<String, dynamic>> dataList = <Map<String, dynamic>>[].obs;

  void fetchDataAndConvertToList() {
    List<Map<String, dynamic>> fetchedData = [
      {
        'address': 'Thủ Đức',
        'photoUrl':
            'https://upload.wikimedia.org/wikipedia/commons/1/15/Ch%E1%BB%A3_Th%E1%BB%A7_%C4%90%E1%BB%A9c.jpg',
      },
      {
        'address': 'Quận 3',
        'photoUrl':
            'https://travelsgcc.com/wp-content/uploads/2020/03/ho-con-rua.jpg',
      },
      {
        'address': 'Bình Thạnh',
        'photoUrl':
            'https://go2joy.s3.ap-southeast-1.amazonaws.com/blog/wp-content/uploads/2023/01/04154942/landmark-81-binh-thanh.jpg',
      },
      {
        'address': 'Quận 1',
        'photoUrl':
            'https://images2.thanhnien.vn/528068263637045248/2023/3/16/base64-16789444054471877099818.png',
      },
      {
        'address': 'Quận 7',
        'photoUrl':
            'https://dulichkhampha24.com/wp-content/uploads/2020/01/cau-anh-sao-sai-gon-3.jpg',
      }
    ];

    dataList.assignAll(fetchedData);
    isLoading.value = false;
  }

  var isLoadMore = Rx<bool>(false);
  var page = Rx<int>(10);
  var listRoom = Rx<List<Room>>([]);

  Future<void> getListRoom(bool isPagination) async {
    if (isPagination) {
      isLoadMore.value = true;
      listRoom.value = (await RoomRepoImpl().getAllRooms()).data as List<Room>;
      isLoadMore.value = false;
    } else {
      isFetchingRoom.value = RoomFetch.LOADING;
      listRoom.value = (await RoomRepoImpl().getAllRooms()).data as List<Room>;
      isFetchingRoom.value = RoomFetch.LOADED;
    }
  }

  // handle google show room around
  var listRoomInArea = Rx<List<Room>>([]);

  Future<void> getListRoomInArea(String area) async {
    //listRoomInArea.value = await FireStoreMethods().getRoomInArea(area, 10);
    List<Room> listFetch =
        (await RoomRepoImpl().getAllRooms()).data as List<Room>;
    if (listFetch.length > listRoomInArea.value.length) {
      listRoomInArea.value = listFetch;
    }
    print('listRoomInArea.length: ${listRoomInArea.value.length}');
    if (listRoomInArea.value.isNotEmpty) {
      for (var room in listRoomInArea.value) {
        isLoadingMap.value = true;
        print(room.address![0]);
      }
    }
  }

  Future<void> getListRoomByListSplit(List<String> areas) async {
    for (var i = 0; i < areas.length; i++) {
      isLoadingMap.value = true;
      print(areas[i]);
      await getListRoomInArea(areas[i].trim());
    }
    isLoadingMap.value = false;
  }
}
