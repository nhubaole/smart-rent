import 'package:flutter/material.dart';
import 'package:smart_rent/core/model/location/city.dart';
import 'package:smart_rent/core/model/location/district.dart';
import 'package:smart_rent/core/model/location/location.dart';
import 'package:smart_rent/core/model/location/ward.dart';
import 'package:smart_rent/core/model/room/room.dart';
import 'package:smart_rent/core/values/app_colors.dart';
import 'package:smart_rent/core/widget/button_fill.dart';
import 'package:smart_rent/core/widget/button_outline.dart';
import 'package:smart_rent/core/widget/like_button.dart';
import 'package:smart_rent/core/widget/room_item.dart';
import 'package:smart_rent/core/widget/text_field_input.dart';
import 'package:smart_rent/core/widget/text_form_field_input.dart';
import 'package:smart_rent/core/widget/toggle_button_custom.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    bool isLiked = true;
    final TextEditingController textEditingController = TextEditingController();
    final bool isPass = false;
    final String labelText = 'Label';
    final String hintText = 'Hint';
    final TextInputType textInputType = TextInputType.emailAddress;
    final BorderRadius borderRadius = BorderRadius.circular(8);
    final double borderWidth = 2;
    final Color borderColor = Colors.blue;
    BorderSide(color: Colors.deepPurple, width: 2);
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: TextFormFieldInput(
                  onSaved: (value) {},
                  onValidate: (p0) {},
                  icon: Icon(Icons.email),
                  textEditingController: textEditingController,
                  labelText: labelText,
                  hintText: hintText,
                  isPassword: true,
                  textInputType: textInputType,
                  borderRadius: borderRadius,
                  borderWidth: borderWidth,
                  borderColor: borderColor,
                ),
              ),
              // Expanded(
              //   child: ButtonFill(
              //     onPressed: () {},
              //     icon: Icon(
              //       Icons.email,
              //       color: Colors.white,
              //     ),
              //     text: Text(
              //       'Button',
              //       style: TextStyle(color: Colors.white),
              //     ),
              //     backgroundColor: primary60,
              //     borderRadius: BorderRadius.circular(20),
              //   ),
              // ),
              // Expanded(
              //   child: ButtonOutline(
              //     onPressed: () {},
              //     icon: Icon(
              //       Icons.email,
              //       color: Colors.red,
              //     ),
              //     text: Text(
              //       'Button',
              //       style: TextStyle(color: Colors.red),
              //     ),
              //     borderWidth: 3,
              //     borderColor: Colors.red,
              //     borderRadius: BorderRadius.circular(20),
              //   ),
              // ),
              const Expanded(
                child: Row(
                  children: [
                    RoomItem(
                      isLiked: true,
                      room: Room(
                        id: '1',
                        title: 'Nhà trọ giá rẻ quá trời',
                        description: 'Thuê điiiii',
                        roomType: 'Phòng trọ',
                        capacity: 2,
                        gender: 'Nữ',
                        area: 25,
                        price: 100000,
                        deposit: 1000000,
                        electricityCost: 0,
                        waterCost: 0,
                        internetCost: 0,
                        hasParking: false,
                        parkingFee: 0,
                        location: Location(
                            street: '1',
                            address: '1',
                            city: City(
                                name: 'Thành phố Hồ Chí Minh',
                                slug: 'slug',
                                type: 'type',
                                name_with_type: 'Thành phố Hồ Chí Minh',
                                code: 'code'),
                            district: District(
                                name: '3',
                                type: 'type',
                                slug: 'slug',
                                name_with_type: 'Quận 3',
                                path: 'path',
                                path_with_type: 'Quận Thủ Đức, thành phố Hồ Chí Minh',
                                code: 'code',
                                parent_code: 'parent_code'),
                            ward: Ward(
                                name: 'name',
                                type: 'type',
                                slug: 'slug',
                                name_with_type: 'name_with_type',
                                path: 'path',
                                path_with_type: 'phường Linh Trung, quận Thủ Đức, thành phố Hồ Chí Minh',
                                code: 'code',
                                parent_code: 'parent_code')),
                        utilities: [],
                        createdByUid: '2',
                        dateTime: '',
                        isRented: true,
                        status: '',
                        images: ['assets/images/sample_room.jpg']
                      ),
                    ),
                    SizedBox(width: 15,),
                    RoomItem(
                      isLiked: false,
                      room: Room(
                        id: '1',
                        title: 'HOMESTAY DOOM MẶT TIỀN HÀNG XANHHHHHHH',
                        description: 'Thuê đi',
                        roomType: 'Phòng trọ',
                        capacity: 2,
                        gender: 'Nữ',
                        area: 25,
                        price: 1000000,
                        deposit: 1000000,
                        electricityCost: 0,
                        waterCost: 0,
                        internetCost: 0,
                        hasParking: false,
                        parkingFee: 0,
                        location: Location(
                            street: '1',
                            address: '1',
                            city: City(
                                name: 'name',
                                slug: 'slug',
                                type: 'type',
                                name_with_type: 'name_with_type',
                                code: 'code'),
                            district: District(
                                name: 'name',
                                type: 'type',
                                slug: 'slug',
                                name_with_type: 'name_with_type',
                                path: 'path',
                                path_with_type: 'Quận 1, Thành phố Hồ Chí Minh',
                                code: 'code',
                                parent_code: 'parent_code'),
                            ward: Ward(
                                name: 'name',
                                type: 'type',
                                slug: 'slug',
                                name_with_type: 'name_with_type',
                                path: 'path',
                                path_with_type: 'phường Tân Định, quận 1, thành phố Hồ Chí Minh',
                                code: 'code',
                                parent_code: 'parent_code')),
                        utilities: [],
                        createdByUid: '2',
                        dateTime: '',
                        isRented: true,
                        status: '',
                        images: ['assets/images/sample_room.jpg']
                      ),
                    ),
                  ],
                ),
              ),
              const Flexible(
                child: ToggleButtonsCustom(dataLength: 3, data: {
                  'Home': Icon(Icons.home),
                  'Work': Icon(Icons.work),
                  'School': Icon(Icons.school),
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
