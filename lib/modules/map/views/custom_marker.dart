import 'package:flutter/material.dart';
import 'package:smart_rent/core/model/room/room.dart';

// ignore: must_be_immutable
class CustomMarker extends StatelessWidget {
  const CustomMarker({
    required this.room,
  });

  final Room room;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          const Align(
            alignment: Alignment.bottomCenter,
            child: Icon(
              Icons.arrow_drop_down,
              color: Colors.black,
              size: 50,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(10),
            color: Colors.black,
            child: Column(
              children: [
                Text(
                  room.title,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Giá: ${room.price.toString()}',
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
