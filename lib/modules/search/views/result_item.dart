import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_rent/core/enums/gender.dart';
import 'package:smart_rent/core/model/room/room.dart';
import 'package:smart_rent/modules/detail/views/detail_screen.dart';

import '../../../core/values/app_colors.dart';

class ResultItem extends StatelessWidget {
  ResultItem({super.key, required this.room});
  final Room room;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(
          DetailScreen(
            isReturnRent: false,
            isRented: false,
            room: room,
            isHandleRequestReturnRoom: false,
          ),
        );
      },
      child: Container(
        width: double.infinity,
        height: 180,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: CachedNetworkImage(
                    height: 120,
                    width: 120,
                    fit: BoxFit.cover,
                    imageUrl: room.images[0])),
            const SizedBox(
              width: 16,
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    getCapacity(room),
                    style: TextStyle(fontSize: 10, color: secondary60),
                  ),
                  Text(
                    room.title,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 18,
                      color: secondary20,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                  ),
                  Text(
                    room.location,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 10, color: secondary20),
                    maxLines: 2,
                  ),
                  Text(
                    priceFormatterFull(room),
                    style: TextStyle(
                      fontSize: 18,
                      color: primary60,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  String getCapacity(Room room) {
    return room?.gender == Gender.ALL
        ? "${room?.capacity} NAM/NỮ"
        : "${room?.capacity} ${room?.gender.getNameGender().toUpperCase()}";
  }

  String priceFormatterFull(Room room) {
    String formattedNumber = room!.price.toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match match) => '${match[1]}.',
        );
    return formattedNumber + " ₫/phòng";
  }
}
