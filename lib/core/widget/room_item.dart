import 'package:flutter/material.dart';

class RoomItem extends StatefulWidget {
  final String roomId;
  const RoomItem({
    super.key,
    required this.roomId,
  });

  @override
  State<RoomItem> createState() => _RoomItemState();
}

class _RoomItemState extends State<RoomItem> {
  @override
  void initState() {
    super.initState();
  }

  getData() async {}
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
