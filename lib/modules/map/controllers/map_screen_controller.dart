import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:smart_rent/core/values/app_colors.dart';

class MapScreenController extends GetxController {
  final bool fromDetailRoom;
  double? lat;
  double? lon;
  MapScreenController({
    required this.fromDetailRoom,
    this.lat,
    this.lon,
  });

  late Completer<GoogleMapController> mapController;
  Location locationController = Location();
  late LocationData locationData;

  var currentPosition = Rx<LatLng?>(null);
  var polylines = Rx<Map<PolylineId, Polyline>>({});
  var markers = Rx<Set<Marker>>({});
  var isLoading = Rx<bool>(false);

  @override
  void onInit() async {
    mapController = Completer<GoogleMapController>();
    await getLocationUpdates().then((_) => {
          getPolylinePoints()
              .then((coordinates) => {generatePolyLineFromPoints(coordinates)})
        });

    super.onInit();
  }

  Future<void> getCurrentLocation() async {}
  Future<void> cameraToPosition(LatLng pos) async {
    final GoogleMapController controller = await mapController.future;
    CameraPosition newCameraPosition = CameraPosition(
      target: pos,
      zoom: 11.0,
    );
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(newCameraPosition),
    );
  }

  Future<void> getLocationUpdates() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    serviceEnabled = await locationController.serviceEnabled();
    if (serviceEnabled) {
      serviceEnabled = await locationController.requestService();
    } else {
      return;
    }
    permissionGranted = await locationController.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await locationController.requestPermission();
      if (permissionGranted == PermissionStatus.granted) {
        return;
      }
    }

    // locationController.onLocationChanged.listen((LocationData currentLocation) {
    //   if (currentLocation.latitude != null &&
    //       currentLocation.longitude != null) {
    //     if (!fromDetailRoom) {
    //       currentPosition.value =
    //           LatLng(currentLocation.latitude!, currentLocation.longitude!);
    //     } else {
    //       currentPosition.value = LatLng(lat!, lon!);
    //     }

    //     //cameraToPosition(currentPosition.value!);
    //   }
    // });

    locationController.onLocationChanged.listen((LocationData currentLocation) {
      if (currentLocation.latitude != null &&
          currentLocation.longitude != null) {
        if (!fromDetailRoom) {
          currentPosition.value =
              LatLng(currentLocation.latitude!, currentLocation.longitude!);
        } else {
          currentPosition.value = LatLng(lat!, lon!);
        }
        // Gọi hàm tạo đường đi mới khi có thay đổi vị trí
        getPolylinePoints().then((coordinates) {
          generatePolyLineFromPoints(coordinates);
        });
        //cameraToPosition(currentPosition.value!);
      }
    });
  }

  Future<List<LatLng>> getPolylinePoints() async {
    List<LatLng> poplylineCoordinates = [];
    PolylinePoints polylinePoints = PolylinePoints();
    String googleMapApiKey = dotenv.env['google_map_api']!;

    LocationData currentLocationUser = await Location().getLocation();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleMapApiKey,
      PointLatLng(
          currentLocationUser.latitude!, currentLocationUser.longitude!),
      PointLatLng(lat!, lon!),
      travelMode: TravelMode.driving,
    );

    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        poplylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    } else {
      print('Error getPoly: ${result.errorMessage}');
    }
    return poplylineCoordinates;
  }

  void generatePolyLineFromPoints(List<LatLng> polylineCoordinates) async {
    PolylineId id = const PolylineId('poly');
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.black,
      points: polylineCoordinates,
      width: 9,
    );
    polylines.value[id] = polyline;
  }

  Future<void> showDialogLoading() async {
    Get.dialog(
      const PopScope(
        canPop: false,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                CircularProgressIndicator(
                  color: primary60,
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  'Đang xử lý dữ liệu bản đồ',
                  style: TextStyle(color: primary60),
                ),
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );

    await Future.delayed(
      const Duration(seconds: 1),
    );
  }
}
