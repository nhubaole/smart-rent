import 'package:flutter/material.dart';
import 'package:smart_rent/core/model/room/room.dart';
import 'package:smart_rent/core/values/app_colors.dart';

class RoomItem extends StatefulWidget {
  final Room room;
  final bool isLiked;
  const RoomItem({
    super.key,
    required this.room,
    required this.isLiked,
  });

  @override
  State<RoomItem> createState() => _RoomItemState();
}

class _RoomItemState extends State<RoomItem> {
  late bool isLiked;

  @override
  void initState() {
    super.initState();
    isLiked = widget.isLiked;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      color: Colors.transparent,
      child: Container(
        width: MediaQuery.of(context).size.width / 2 - 30,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Stack(
              children: [
                Container(
                  height: 120,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fitWidth,
                      image: AssetImage(widget.room.images[0]),
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: IconButton(
                    iconSize: 30,
                    color: isLiked ? red60 : Colors.white,
                    onPressed: () {
                      setState(() {
                        isLiked = !isLiked;
                      });
                    },
                    icon: isLiked
                        ? Icon(Icons.favorite)
                        : Icon(Icons.favorite_outline),
                  ),
                )
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: primary40,
                      borderRadius: BorderRadius.circular(6.0)),
                  padding: EdgeInsets.all(5.0),
                  child: Row(
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
                SizedBox(
                  width: 5.0,
                ),
                Text(
                  'Tốt',
                  style: TextStyle(
                      fontSize: 12,
                      color: secondary20,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  width: 5.0,
                ),
                Container(
                  height: 4,
                  width: 4,
                  decoration: BoxDecoration(
                      color: secondary40,
                      borderRadius: BorderRadius.circular(2)),
                ),
                SizedBox(
                  width: 5.0,
                ),
                Text(
                  '24 đánh giá',
                  style: TextStyle(
                      fontSize: 12,
                      color: secondary40,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
            SizedBox(height: 5),
            Text(
              widget.room.title,
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: secondary20),
            ),
            Text(
              widget.room.price >= 1000000
                  ? '${widget.room.price / 1000000} triệu VND/người'
                  : '${widget.room.price} VND/người',
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: TextStyle(
                  fontSize: 14, fontWeight: FontWeight.bold, color: primary40),
            ),
            Text(
              '${widget.room.location}',
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: secondary40),
            ),
          ],
        ),
      ),
    );
  }
}
