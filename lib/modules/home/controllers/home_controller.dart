import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:smart_rent/core/app/app_manager.dart';
import 'package:smart_rent/core/di/getit_config.dart';
import 'package:smart_rent/core/enums/room_fetch.dart';
import 'package:smart_rent/core/model/room/room_model.dart';
import 'package:smart_rent/core/model/user/user_model.dart';
import 'package:smart_rent/core/repositories/log/log.dart';
import 'package:smart_rent/core/repositories/room/room_repo_impl.dart';
import 'package:smart_rent/core/repositories/user/user_repo_iml.dart';
import 'package:smart_rent/modules/chat/socket_service.dart';
import 'package:smart_rent/modules/home/widgets/confirm_upgrade_landlord_sheet.dart';
import 'package:smart_rent/modules/user_profile/user_profile_controller.dart';
import '/core/resources/google_map_services.dart';

class HomeController extends GetxController {
  late Log logger;
  final AppManager appManager = AppManager();

  final isScrollingUp = false.obs;
  final currenLocation = ''.obs;
  final currenPhone = ''.obs;
  Location? crLocation;
  final isLoading = true.obs;
  final isFetchingRoom = RoomFetch.LOADING.obs;
  final isLoadingMap = Rx<bool>(true);
  final currencyFormat = NumberFormat.currency(locale: 'vi_VN', symbol: '');
  UserModel get currentUser => appManager.currentUser!;

  String get fullName => currentUser.fullName ?? '--';

  @override
  void onInit() async {
    logger = getIt<Log>();
    setupFirebaseMessaging();
    setupSocket();
    fetchDataAndConvertToList();
    getListRoom(false);
    getCurrentLocation();
    super.onInit();
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
    // await getListRoomByListSplit(areas);
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

  final isLoadMore = Rx<bool>(false);
  final page = Rx<int>(10);
  final listRoom = Rx<List<RoomModel>>([]);

  Future<void> getListRoom(bool isPagination) async {
    if (isPagination) {
      isLoadMore.value = true;
      final rq = await RoomRepoImpl().getAllRooms();
      if (rq.isSuccess()) {
        listRoom.value = rq.data!;
        isLoadMore.value = false;
      }
    } else {
      isFetchingRoom.value = RoomFetch.LOADING;
      final result = await RoomRepoImpl().getAllRooms();
      if (result.isSuccess()) {
        listRoom.value = result.data as List<RoomModel>;

        isFetchingRoom.value = RoomFetch.LOADED;
      } else {
        isFetchingRoom.value = RoomFetch.ERROR;
      }
    }
  }

  // handle google show room around
  final listRoomInArea = Rx<List<RoomModel>>([]);

  Future<void> getListRoomInArea(String area) async {
    List<RoomModel> listFetch =
        (await RoomRepoImpl().getAllRooms()).data as List<RoomModel>;
    if (listFetch.length > listRoomInArea.value.length) {
      listRoomInArea.value = listFetch;
    }
  }

  Future<void> getListRoomByListSplit(List<String> areas) async {
    for (var i = 0; i < areas.length; i++) {
      isLoadingMap.value = true;
      await getListRoomInArea(areas[i].trim());
    }
    isLoadingMap.value = false;
  }

  Future<void> setupFirebaseMessaging() async {
    await FirebaseMessaging.instance.requestPermission();
    
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    String? token = await messaging.getToken();
    print("Device Token: $token");

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        AwesomeNotifications().createNotification(
          content: NotificationContent(
            id: DateTime.now().millisecondsSinceEpoch.remainder(100000),
            channelKey: 'basic_channel',
            title: message.notification!.title ?? 'Thông báo mới',
            body: message.notification!.body ?? 'Bạn có một thông báo mới!',
            notificationLayout: NotificationLayout.Default,
          ),
        );
      }
    });

    if (token != null) {
      await saveDeviceToken(token);
    }
  }

  void setupSocket() {
    final SocketService socketService = Get.put(SocketService());
    socketService.initializeSocket(userId: AppManager().currentUser?.id.toString() ?? "");
  }

  Future<void> saveDeviceToken(String token) async {
    UserRepoIml().updateDeviceToken(deviceToken: token);
    return;
  }

  onAskToUpgradeToLandlord() {
    Get.bottomSheet(
      ConfirmUpgradeLandlordSheet(
        onConfirm: onUpgradeToLandlord,
      ),
    );
  }

  onUpgradeToLandlord() {
    if (Get.isRegistered<UserProfileController>()) {
      Get.find<UserProfileController>().onUpgradeToLandlord();
    }
  }
}
