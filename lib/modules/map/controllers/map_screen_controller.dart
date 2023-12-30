import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:smart_rent/core/model/room/room.dart';
import 'package:smart_rent/core/resources/google_map_services.dart';

class MapScreenController extends GetxController {
  final bool fromDetailRoom;
  double? lat;
  double? lon;
  List<Room>? roomInArea;
  MapScreenController({
    required this.fromDetailRoom,
    this.lat,
    this.lon,
    this.roomInArea,
  });
  final Completer<GoogleMapController> mapController =
      Completer<GoogleMapController>();

  //late GoogleMapController ggMapController;
  var listPolylines = Rx<Set<Polyline>>({});
  var polylines = Rx<Map<PolylineId, Polyline>>({});
  var listMarkers = Rx<List<Marker>>([]);
  var currentPosition = Rx<LatLng?>(null);
  var destination = Rx<LatLng?>(null);
  var isLoading = Rx<bool>(false);
  @override
  void onInit() async {
    print(roomInArea);
    await getCurrentLocation();
    if (fromDetailRoom == true) {
      destination.value = LatLng(lat!, lon!);
      await getPolylinePoints();
    } else {
      await getListMarkers(roomInArea!);
    }

    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
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

    currentPosition.value = LatLng(lat!, lon!);
  }

  Future<void> cameraToPosition(LatLng pos) async {
    GoogleMapController ggMapController = await mapController.future;
    CameraPosition newCameraPosition = CameraPosition(
      target: pos,
      zoom: 11,
    );

    await ggMapController.animateCamera(
      CameraUpdate.newCameraPosition(newCameraPosition),
    );
  }

  Future<void> cameraToRoute() async {
    GoogleMapController ggMapController = await mapController.future;
    await ggMapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(
              currentPosition.value!.latitude,
              currentPosition.value!.longitude,
            ),
            zoom: 20.0),
      ),
    );
  }

  Future<List<LatLng>> getPolylinePoints() async {
    List<LatLng> polylineCoordinates = [];
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      dotenv.env['google_map_api']!,
      PointLatLng(
        currentPosition.value!.latitude,
        currentPosition.value!.longitude,
      ),
      PointLatLng(lat!, lon!),
      //PointLatLng(21.036061770676426, 105.83355592370253),
    );
    listMarkers.value.add(
      Marker(
        markerId: const MarkerId('Phòng thuê'),
        position: LatLng(lat!, lon!),
        infoWindow: const InfoWindow(title: 'Business 1'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      ),
    );
    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        isLoading.value = true;
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    } else {
      print(result.errorMessage);
    }

    print(polylineCoordinates);
    await generatePolylineFromPoint(polylineCoordinates);
    isLoading.value = false;
    return polylineCoordinates;
  }

  Future<List<LatLng>> getPolylinePointsInArea(LatLng latLng) async {
    List<LatLng> polylineCoordinates = [];
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      dotenv.env['google_map_api']!,
      PointLatLng(
        currentPosition.value!.latitude,
        currentPosition.value!.longitude,
      ),
      PointLatLng(latLng.latitude, latLng.longitude),
      //PointLatLng(21.036061770676426, 105.83355592370253),
    );

    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        isLoading.value = true;
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    } else {
      print(result.errorMessage);
    }

    //print(polylineCoordinates);
    await generatePolylineFromPoint(polylineCoordinates);
    isLoading.value = false;
    return polylineCoordinates;
  }

  Color randomColor() {
    Random random = Random();
    return Color.fromRGBO(
      256,
      random.nextInt(256),
      random.nextInt(256),
      1.0,
    );
  }

  Future<void> generatePolylineFromPoint(List<LatLng> points) async {
    print(points);
    PolylineId id = const PolylineId('poly');
    Polyline polyline = Polyline(
      polylineId: id,
      color: randomColor(),
      points: points,
      width: 6,
    );
    polylines.value[id] = polyline;
    listPolylines.value.add(polyline);
    //await cameraToRoute();
  }

  Future<void> getListMarkers(List<Room> listRoomInArea) async {
    if (listRoomInArea.isNotEmpty) {
      for (var i = 0; i < listRoomInArea.length; i++) {
        isLoading.value = true;
        LatLng latLng = await GoogleMapServices().getLatLngFromAddress(
          listRoomInArea[i].location,
          'vi',
        );
        await getPolylinePointsInArea(latLng);
        listMarkers.value.add(
          Marker(
            markerId: MarkerId(listRoomInArea[i].title),
            position: latLng,
            infoWindow: const InfoWindow(title: 'Business 1'),
            icon:
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          ),
        );
      }
    }
    isLoading.value = false;
  }
}
