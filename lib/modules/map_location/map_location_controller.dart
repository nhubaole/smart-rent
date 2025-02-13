import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/enums/loading_type.dart';
import 'package:smart_rent/core/extension/double_extension.dart';
import 'package:smart_rent/core/model/room/room_model.dart';
import 'package:smart_rent/core/repositories/room/room_repo_impl.dart';
import 'package:smart_rent/core/resources/google_map_services.dart';
import 'package:smart_rent/core/routes/app_routes.dart';
import 'package:smart_rent/core/values/image_assets.dart';
import 'package:smart_rent/core/widget/map_location_room_detail_sheet.dart';
import 'package:smart_rent/modules/home/controllers/home_controller.dart';
import 'package:smart_rent/modules/map_location/widgets/chose_scope_radius_sheet.dart';

class MapLocationController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final departureController = TextEditingController();
  final scopeRadiusController = TextEditingController();
  final debouncer = Debouncer(delay: const Duration(milliseconds: 500));

  final isLoadingData = LoadingType.LOADED.obs;
  final mapController = Rxn<GoogleMapController>();
  final currentPosition = Rxn<LatLng>();
  final isShowDestination = false.obs;
  final isOpenRooms = true.obs;
  final currentDistance = 0.0.obs;
  final maxDistance = 100.0.obs;
  final listRooms = <RoomModel>[].obs;
  final isFetching = false.obs;

  final Set<Marker> markers = {};
  final listLatLon = <LatLng>[
    LatLng(10.779783, 106.699186), // Notre-Dame Cathedral Basilica
    LatLng(10.772376, 106.698305), // Ben Thanh Market
    LatLng(10.776889, 106.695773), // Independence Palace
    LatLng(10.776643, 106.695432), // War Remnants Museum
    LatLng(10.779282, 106.698336), // Saigon Central Post Office
    LatLng(10.771654, 106.704292), // Bitexco Financial Tower
    LatLng(10.771977, 106.703185), // Nguyen Hue Walking Street
    LatLng(10.768695, 106.693231), // Bui Vien Walking Street
    LatLng(10.789568, 106.705202), // Saigon Zoo and Botanical Gardens
    LatLng(10.794187, 106.721779), // Landmark 81
    LatLng(10.752048, 106.665567), // Thien Hau Temple
    LatLng(10.789102, 106.688515), // Tan Dinh Church
    LatLng(10.776531, 106.698801), // Ho Chi Minh City Museum
    LatLng(10.867059, 106.802139), // Suoi Tien Theme Park
    LatLng(10.760035, 106.645785), // Dam Sen Water Park
  ].obs;

  /// Animation list room suggestion
  late final AnimationController animationController;
  late final Animation<Offset> offsetAnimation;

  @override
  void onInit() {
    currentPosition.value = Get.find<HomeController>().currLatLon.value!;
    if (currentPosition.value == null) {
      Get.back();
    }
    departureController.addListener(() {
      departureController.text.isNotEmpty
          ? isShowDestination.value = true
          : isShowDestination.value = false;
    });
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    final double dy = 210.px / Get.height;
    offsetAnimation = Tween<Offset>(
      begin: Offset(0, 0),
      end: Offset(0, dy),
    ).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeInOut));
    // fetchRooms();
    hideRooms();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    departureController.dispose();
    scopeRadiusController.dispose();
    animationController.dispose();
    super.onClose();
  }

  addMarkers() async {
    markers.add(
      Marker(
        markerId: MarkerId('current'),
        draggable: true,
        position: currentPosition.value!,
        infoWindow: InfoWindow(
          title: 'Vị trí hiện tại',
          // snippet: room.description,
        ),
        
      ),
    );

    final AssetMapBitmap iconHomeStay = await BitmapDescriptor.asset(
        ImageConfiguration(size: Size(48.px, 60.px)), ImageAssets.icHomeStay);
    final AssetMapBitmap iconHomeForRent = await BitmapDescriptor.asset(
        ImageConfiguration(size: Size(48.px, 60.px)),
        ImageAssets.icHomeForRent);
    final AssetMapBitmap iconRoomFullRent = await BitmapDescriptor.asset(
        ImageConfiguration(size: Size(48.px, 60.px)),
        ImageAssets.icRoomFullRent);
    final AssetMapBitmap icBuilding = await BitmapDescriptor.asset(
        ImageConfiguration(size: Size(48.px, 60.px)), ImageAssets.icBuilding);

    for (int i = 0; i < listRooms.length; i++) {
      AssetMapBitmap cIcon = iconHomeStay;
      final room = listRooms[i];
      switch (room.roomType) {
        case "Kí túc xá/Homestay":
          cIcon = iconHomeStay;
          break;
        case "Phòng cho thuê":
          cIcon = iconHomeForRent;
          break;
        case "Nhà nguyên căn":
          cIcon = iconRoomFullRent;
          break;
        case "Căn hộ":
          cIcon = icBuilding;
      }
      final location = LatLng(room.latitude ?? 0, room.longitude ?? 0);
      log(location.toString());
      markers.add(
        Marker(
          markerId: MarkerId(i.toString()),
          draggable: true,
          position: location,
          infoWindow: InfoWindow(
            title: room.title,
            snippet: 'Giá: ${room.totalPrice?.toStringTotalPrice}',
          ),
          icon: cIcon,
          onTap: () {
            Get.bottomSheet(
              MapLocationRoomDetailSheet(
                room: room,
              ),
            );
          },
        ),
      );
    }
  }

  fetchRooms() async {
    if (currentDistance.value == 0 || currentPosition.value == null) {
      return;
    }
    isFetching.value = true;
    markers.clear();
    debouncer(() async {
      isLoadingData.value = LoadingType.LOADING;
      final response =
          await RoomRepoImpl().getRoomsByAddressAndLocationElasticSearch(
        distance: currentDistance.value,
        location: currentPosition.value!,
      );
      if (response.isSuccess()) {
        listRooms.assignAll(response.data!);
        addMarkers();
        showRooms();
        isLoadingData.value = LoadingType.LOADED;
      } else {
        isLoadingData.value = LoadingType.ERROR;
      }
      isFetching.value = false;
    });
  }

  submitSearch() {
    fetchRooms();
  }

  setLatlonLocation(double lat, double lon) {
    currentPosition.value = LatLng(lat, lon);
  }

  toggleShowRooms() {
    if (isOpenRooms.value) {
      hideRooms();
    } else {
      showRooms();
    }
  }

  showRooms() {
    isOpenRooms.value = true;
    animationController.reverse();
  }

  hideRooms() {
    isOpenRooms.value = false;
    animationController.forward();
  }

  onMapCreated(GoogleMapController controller) {
    mapController.value = controller;
  }

  onBack() {
    Get.delete<MapLocationController>(force: true);
    Get.back();
  }

  onChangeDistance(double value) {
    currentDistance.value = value;
    fetchRooms();
  }

  onSearch() async {
    if (currentDistance.value != 0.0 && departureController.text.isNotEmpty) {
      fetchRooms();
    }
  }

  onNavSearch() async {
    final result = await Get.toNamed(AppRoutes.mapSearch,
        arguments: departureController.text);
    if (result != null) {
      departureController.text = result;
      final currLatLon = await GoogleMapServices()
          .getLatLngFromAddress(departureController.text, 'vi');
      if (currLatLon != null) {
        currentPosition.value = currLatLon;
        fetchRooms();
      }
    }
  }

  showChoseScopeRadiusSheet() {
    Get.bottomSheet(
      ChoseScopeRadiusSheet(),
    ).then((distance) {
      if (distance != null) {
        scopeRadiusController.text = 'Cách < $distance km';
        currentDistance.value = distance;
        fetchRooms();
      }
    });
  }
}
