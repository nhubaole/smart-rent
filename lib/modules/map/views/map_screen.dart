import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smart_rent/core/model/room/room.dart';
import 'package:smart_rent/core/values/app_colors.dart';
import 'package:smart_rent/modules/map/controllers/map_screen_controller.dart';

// ignore: must_be_immutable
class MapScreen extends StatefulWidget {
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
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late MapScreenController mapController;
  @override
  void initState() {
    mapController = Get.put(
      MapScreenController(
        fromDetailRoom: widget.fromDetailRoom,
        lat: widget.lat,
        lon: widget.lon,
        roomInArea: widget.roomInArea,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Obx(
        () => mapController.currentPosition.value == null
            ? const Center(
                child: CircularProgressIndicator(
                  color: primary95,
                  backgroundColor: primary40,
                ),
              )
            : mapController.isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(
                      color: primary95,
                      backgroundColor: primary40,
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
