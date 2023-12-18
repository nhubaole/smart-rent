import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_rent/core/model/room/room.dart';
import 'package:smart_rent/core/resources/firestore_methods.dart';
import 'package:smart_rent/core/values/app_colors.dart';
import 'package:smart_rent/modules/detail/views/detail_screen.dart';

class RoomItem extends StatefulWidget {
  final Room room;
  final bool isLiked;
  final bool isRented;
  final bool isReturnRent;
  final bool isHandleRequestReturnRoom;
  const RoomItem({
    super.key,
    required this.room,
    required this.isLiked,
    required this.isRented,
    required this.isReturnRent,
    required this.isHandleRequestReturnRoom,
  });

  @override
  State<RoomItem> createState() => _RoomItemState();
}

class _RoomItemState extends State<RoomItem> {
  late bool isLiked;
  late double deviceHeight;
  late double deviceWidth;

  @override
  void initState() {
    super.initState();
    isLiked = widget.isLiked;
  }

  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: () {
        Get.to(
          DetailScreen(
            isReturnRent: widget.isReturnRent,
            isRented: widget.isRented,
            room: widget.room,
            isHandleRequestReturnRoom: widget.isHandleRequestReturnRoom,
          ),
        );
      },
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: deviceWidth * 0.02,
            vertical: deviceHeight * 0.01,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Flexible(
                child: Stack(
                  children: [
                    Container(
                      height: 120,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.fitWidth,
                          image:
                              CachedNetworkImageProvider(widget.room.images[0]),
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(12.0),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: IconButton(
                        iconSize: 30,
                        color: isLiked ? red60 : Colors.white,
                        onPressed: () {
                          FireStoreMethods().likePost(
                            widget.room.id,
                            FirebaseAuth.instance.currentUser!.uid,
                            widget.room.listLikes,
                          );
                          setState(() {
                            isLiked = !isLiked;
                          });
                        },
                        icon: isLiked
                            ? const Icon(Icons.favorite)
                            : const Icon(Icons.favorite_outline),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: deviceHeight * 0.01,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: primary40,
                            borderRadius:
                                BorderRadius.circular(deviceWidth * 0.01),
                          ),
                          padding: EdgeInsets.all(deviceWidth * 0.005),
                          child: const Row(
                            children: [
                              Text(
                                '4.2',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                width: 3,
                              ),
                              Icon(
                                Icons.star,
                                color: Color(0xFFffd21d),
                                size: 16,
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        const Text(
                          'Tốt',
                          style: TextStyle(
                              fontSize: 12,
                              color: secondary20,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        Container(
                          height: 4,
                          width: 4,
                          decoration: BoxDecoration(
                              color: secondary40,
                              borderRadius: BorderRadius.circular(2)),
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          '${widget.room.listComments.length} đánh giá',
                          style: const TextStyle(
                              fontSize: 12,
                              color: secondary40,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    SizedBox(height: deviceHeight * 0.01),
                    Text(
                      widget.room.title,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: secondary20,
                      ),
                    ),
                    Text(
                      widget.room.price >= 1000000
                          ? '${widget.room.price / 1000000} triệu VND/người'
                          : '${widget.room.price} VND/người',
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: primary40,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        widget.room.location,
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: secondary40,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
