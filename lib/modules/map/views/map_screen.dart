import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../core/config/app_colors.dart';
import '/core/model/room/room.dart';
import '/core/values/app_colors.dart';
import '/modules/map/controllers/map_screen_controller.dart';

// ignore: must_be_immutable
class MapScreen extends StatelessWidget {
  MapScreen({
    super.key,
    required this.fromDetailRoom,
    this.lat,
    this.lon,
    this.roomInArea,
  });
  final bool fromDetailRoom;
  double? lat = 0;
  double? lon = 0;
  List<Room>? roomInArea;

  @override
  Widget build(BuildContext context) {
    MapScreenController mapController;
    mapController = Get.put(
      MapScreenController(
        fromDetailRoom: fromDetailRoom,
        lat: lat,
        lon: lon,
        roomInArea: roomInArea,
      ),
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Obx(
        () => mapController.currentPosition.value == null &&
                mapController.isLoading.value == false
            ? const Center(
                child: CircularProgressIndicator(
                  color: AppColors.primary95,
                  backgroundColor: AppColors.primary40,
                ),
              )
            : mapController.isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primary95,
                      backgroundColor: AppColors.primary40,
                    ),
                  )
                : Obx(
                    () => GoogleMap(
                      onMapCreated: (GoogleMapController controller) {
                        //mapController.ggMapController = controller;
                        mapController.mapController.complete(controller);
                      },
                      initialCameraPosition: CameraPosition(
                        target: mapController.currentPosition.value!,
                        zoom: 11.0,
                      ),
                      myLocationEnabled: true,
                      mapToolbarEnabled: true,
                      rotateGesturesEnabled: true,
                      scrollGesturesEnabled: true,
                      tiltGesturesEnabled: true,
                      polylines: Set<Polyline>.of(
                        mapController.listPolylines.value,
                      ),
                      markers: Set<Marker>.of(
                        mapController.listMarkers.value,
                      ),
                    ),
                  ),
      ),
    );
  }
}
