import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smart_rent/core/values/app_colors.dart';
import 'package:smart_rent/modules/map/controllers/map_screen_controller.dart';

// ignore: must_be_immutable
class MapScreen extends StatefulWidget {
  MapScreen({super.key, required this.fromDetailRoom, this.lat, this.lon});
  final bool fromDetailRoom;
  double? lat = 0;
  double? lon = 0;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late MapScreenController mapController;
  @override
  void initState() {
    widget.fromDetailRoom
        ? mapController = Get.put(
            MapScreenController(
              fromDetailRoom: widget.fromDetailRoom,
              lat: widget.lat,
              lon: widget.lon,
            ),
          )
        : mapController = Get.put(
            MapScreenController(
              fromDetailRoom: widget.fromDetailRoom,
            ),
          );
    mapController.getLocationUpdates().then((value) => {
          mapController.getPolylinePoints().then(
              (value) => {mapController.generatePolyLineFromPoints(value)})
        });

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
                  backgroundColor: primary95,
                  color: primary98,
                ),
              )
            : GoogleMap(
                myLocationButtonEnabled: true,
                myLocationEnabled: true,
                rotateGesturesEnabled: true,
                scrollGesturesEnabled: true,
                tiltGesturesEnabled: true,
                onMapCreated: ((GoogleMapController controller) =>
                    mapController.mapController.complete(controller)),
                initialCameraPosition: CameraPosition(
                  target: mapController.currentPosition.value!,
                  zoom: 11.0,
                ),
                markers: {
                  Marker(
                    markerId: const MarkerId('_currentLocation'),
                    icon: BitmapDescriptor.defaultMarker,
                    position: mapController.currentPosition.value!,
                  )
                },
                polylines:
                    Set<Polyline>.of(mapController.polylines.value.values),
              ),
      ),
    );
  }
}
