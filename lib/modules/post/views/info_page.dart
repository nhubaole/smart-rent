import 'package:flutter/material.dart';
import 'package:smart_rent/core/enums/gender.dart';
import 'package:smart_rent/core/enums/room_type.dart';
import 'package:smart_rent/core/values/app_colors.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({super.key});

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  RoomType? _type = RoomType.DORMITORY_HOMESTAY;
  Gender? _gender = Gender.ALL;
  bool? switch1 = false;
  bool? check1 = false;
  
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      width: double.infinity,
      margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: ListView(
        children: [
          Text(
            'Thông tin phòng',
            style: TextStyle(
                color: primary40, fontSize: 18, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 20,
          ),

          //---------------------Room type-------------------------
          Text(
            'LOẠI PHÒNG',
            style: TextStyle(
                color: secondary40, fontSize: 16, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 10,
          ),
          typeOption(),
          SizedBox(
            height: 16,
          ),

          //---------------------Capacity-------------------------
          Text(
            'SỨC CHỨA',
            style: TextStyle(
                color: secondary40, fontSize: 16, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Nhập số người/phòng',
              suffixText: 'người/phòng',
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: primary40, width: 2)),
            ),
          ),
          SizedBox(
            height: 16,
          ),

          //---------------------Gender-------------------------
          Text(
            'GIỚI TÍNH',
            style: TextStyle(
                color: secondary40, fontSize: 16, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 10,
          ),
          genderOption(),
          SizedBox(
            height: 16,
          ),

          //---------------------Area-------------------------
          Text(
            'DIỆN TÍCH',
            style: TextStyle(
                color: secondary40, fontSize: 16, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Nhập diện tích phòng',
              suffixText: 'm2',
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: primary40, width: 2)),
            ),
          ),
          SizedBox(
            height: 20,
          ),

          Text(
            'Chi phí',
            style: TextStyle(
                color: primary40, fontSize: 18, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 20,
          ),

          //---------------------Price-------------------------
          Text(
            'GIÁ CHO THUÊ',
            style: TextStyle(
                color: secondary40, fontSize: 16, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Nhập giá cho thuê',
              suffixText: '₫/phòng',
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: primary40, width: 2)),
            ),
          ),
          SizedBox(
            height: 16,
          ),

          //---------------------Deposit-------------------------
          Text(
            'ĐẶT CỌC',
            style: TextStyle(
                color: secondary40, fontSize: 16, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Nhập số tiền đặt cọc',
              suffixText: '₫',
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: primary40, width: 2)),
            ),
          ),
          SizedBox(
            height: 16,
          ),

          //---------------------Electricity-------------------------
          Row(
            children: [
              Expanded(
                child: Text(
                  'TIỀN ĐIỆN',
                  style: TextStyle(
                      color: secondary40,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Builder(builder: (context) {
                final MaterialStateProperty<Color?> trackColor =
                    MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.selected)) {
                      return primary40;
                    }
                    return secondary80;
                  },
                );
                final MaterialStateProperty<Color?> overlayColor =
                    MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                    // Material color when switch is selected.
                    if (states.contains(MaterialState.selected)) {
                      return primary40.withOpacity(0.54);
                    }
                    return null;
                  },
                );

                return Switch(
                  // This bool value toggles the switch.
                  value: switch1!,
                  overlayColor: overlayColor,
                  trackColor: trackColor,
                  thumbColor:
                      const MaterialStatePropertyAll<Color>(Colors.white),
                  onChanged: (bool value) {
                    // This is called when the user toggles the switch.
                    setState(() {
                      switch1 = value;
                    });
                  },
                );
              }),
              SizedBox(
                width: 10,
              ),
              Text(
                'Miễn phí',
                style: TextStyle(
                    color: switch1! ? primary40 : secondary40,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Nhập số tiền',
              suffixText: '₫',
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: primary40, width: 2)),
            ),
          ),
          SizedBox(
            height: 16,
          ),

          //---------------------Water-------------------------
          Row(
            children: [
              Expanded(
                child: Text(
                  'TIỀN NƯỚC',
                  style: TextStyle(
                      color: secondary40,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Builder(builder: (context) {
                final MaterialStateProperty<Color?> trackColor =
                    MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.selected)) {
                      return primary40;
                    }
                    return secondary80;
                  },
                );
                final MaterialStateProperty<Color?> overlayColor =
                    MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                    // Material color when switch is selected.
                    if (states.contains(MaterialState.selected)) {
                      return primary40.withOpacity(0.54);
                    }
                    return null;
                  },
                );

                return Switch(
                  // This bool value toggles the switch.
                  value: switch1!,
                  overlayColor: overlayColor,
                  trackColor: trackColor,
                  thumbColor:
                      const MaterialStatePropertyAll<Color>(Colors.white),
                  onChanged: (bool value) {
                    // This is called when the user toggles the switch.
                    setState(() {
                      switch1 = value;
                    });
                  },
                );
              }),
              SizedBox(
                width: 10,
              ),
              Text(
                'Miễn phí',
                style: TextStyle(
                    color: switch1! ? primary40 : secondary40,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Nhập số tiền',
              suffixText: '₫',
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: primary40, width: 2)),
            ),
          ),
          SizedBox(
            height: 16,
          ),

          //---------------------Internet-------------------------
          Row(
            children: [
              Expanded(
                child: Text(
                  'TIỀN INTERNET/WIFI',
                  style: TextStyle(
                      color: secondary40,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Builder(builder: (context) {
                final MaterialStateProperty<Color?> trackColor =
                    MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.selected)) {
                      return primary40;
                    }
                    return secondary80;
                  },
                );
                final MaterialStateProperty<Color?> overlayColor =
                    MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                    // Material color when switch is selected.
                    if (states.contains(MaterialState.selected)) {
                      return primary40.withOpacity(0.54);
                    }
                    return null;
                  },
                );

                return Switch(
                  // This bool value toggles the switch.
                  value: switch1!,
                  overlayColor: overlayColor,
                  trackColor: trackColor,
                  thumbColor:
                      const MaterialStatePropertyAll<Color>(Colors.white),
                  onChanged: (bool value) {
                    // This is called when the user toggles the switch.
                    setState(() {
                      switch1 = value;
                    });
                  },
                );
              }),
              SizedBox(
                width: 10,
              ),
              Text(
                'Miễn phí',
                style: TextStyle(
                    color: switch1! ? primary40 : secondary40,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Nhập số tiền',
              suffixText: '₫',
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: primary40, width: 2)),
            ),
          ),
          SizedBox(
            height: 16,
          ),

          //---------------------Parking-------------------------
          CheckboxListTile(
            contentPadding: EdgeInsets.all(0),
            title: Text('Có chỗ để xe'),
            value: check1,
            onChanged: (bool? value) {
              setState(() {
                check1 = value;
              });
            },
            controlAffinity: ListTileControlAffinity.leading,
            visualDensity: const VisualDensity(
              horizontal: VisualDensity.minimumDensity,
              vertical: VisualDensity.minimumDensity,
            ),
            activeColor: primary40,
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  'PHÍ GIỮ XE',
                  style: TextStyle(
                      color: secondary40,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Builder(builder: (context) {
                final MaterialStateProperty<Color?> trackColor =
                    MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.selected)) {
                      return primary40;
                    }
                    return secondary80;
                  },
                );
                final MaterialStateProperty<Color?> overlayColor =
                    MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                    // Material color when switch is selected.
                    if (states.contains(MaterialState.selected)) {
                      return primary40.withOpacity(0.54);
                    }
                    return null;
                  },
                );

                return Switch(
                  // This bool value toggles the switch.
                  value: switch1!,
                  overlayColor: overlayColor,
                  trackColor: trackColor,
                  thumbColor:
                      const MaterialStatePropertyAll<Color>(Colors.white),
                  onChanged: (bool value) {
                    // This is called when the user toggles the switch.
                    setState(() {
                      switch1 = value;
                    });
                  },
                );
              }),
              SizedBox(
                width: 10,
              ),
              Text(
                'Miễn phí',
                style: TextStyle(
                    color: switch1! ? primary40 : secondary40,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Nhập số tiền',
              suffixText: '₫',
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: primary40, width: 2)),
            ),
          ),
          SizedBox(
            height: 16,
          ),
        ],
      ),
    ));
  }

  Widget typeOption() {
    return Column(
      children: <Widget>[
        radioTypeItem(RoomType.DORMITORY_HOMESTAY),
        Divider(
          thickness: 0.7,
        ),
        radioTypeItem(RoomType.ROOM),
        Divider(
          thickness: 0.7,
        ),
        radioTypeItem(RoomType.WHOLE_HOUSE),
        Divider(
          thickness: 0.7,
        ),
        radioTypeItem(RoomType.APARTMENT),
        Divider(
          thickness: 0.7,
        ),
      ],
    );
  }

  Widget genderOption() {
    return Column(
      children: <Widget>[
        radioGenderItem(Gender.ALL),
        Divider(
          thickness: 0.7,
        ),
        radioGenderItem(Gender.MALE),
        Divider(
          thickness: 0.7,
        ),
        radioGenderItem(Gender.FEMALE),
        Divider(
          thickness: 0.7,
        ),
      ],
    );
  }

  RadioListTile radioTypeItem(RoomType type) {
    return RadioListTile<RoomType>(
      activeColor: primary40,
      visualDensity: const VisualDensity(
        horizontal: VisualDensity.minimumDensity,
        vertical: VisualDensity.minimumDensity,
      ),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      contentPadding: EdgeInsets.all(0),
      title: Text(
        type.getNameRoomType(),
        style: TextStyle(color: secondary20, fontSize: 16),
      ),
      value: type,
      groupValue: _type,
      onChanged: (RoomType? value) {
        setState(() {
          _type = value;
        });
      },
    );
  }

  RadioListTile radioGenderItem(Gender gender) {
    return RadioListTile<Gender>(
      activeColor: primary40,
      visualDensity: const VisualDensity(
        horizontal: VisualDensity.minimumDensity,
        vertical: VisualDensity.minimumDensity,
      ),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      contentPadding: EdgeInsets.all(0),
      title: Text(
        gender.getNameGender(),
        style: TextStyle(color: secondary20, fontSize: 16),
      ),
      value: gender,
      groupValue: _gender,
      onChanged: (Gender? value) {
        setState(() {
          _gender = value;
        });
      },
    );
  }
}

