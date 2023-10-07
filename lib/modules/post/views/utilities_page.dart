import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:smart_rent/core/enums/utilities.dart';
import 'package:smart_rent/core/model/room/util_item.dart';
import 'package:smart_rent/core/widget/button_fill.dart';

import '../../../core/values/app_colors.dart';

class UtilitiesPage extends StatefulWidget {
  const UtilitiesPage({super.key});

  @override
  State<UtilitiesPage> createState() => _UtilitiesPageState();
}

class _UtilitiesPageState extends State<UtilitiesPage> {
  List<UtilItem> utilList = [
    UtilItem(utility: Utilities.WC, isChecked: false),
    UtilItem(utility: Utilities.WINDOW, isChecked: false),
    UtilItem(utility: Utilities.WIFI, isChecked: false),
    UtilItem(utility: Utilities.KITCHEN, isChecked: false),
    UtilItem(utility: Utilities.LAUNDRY, isChecked: false),
    UtilItem(utility: Utilities.FRIDGE, isChecked: false),
    UtilItem(utility: Utilities.PARKING, isChecked: false),
    UtilItem(utility: Utilities.SECURITY, isChecked: false),
    UtilItem(utility: Utilities.FLEXIBLE_HOURS, isChecked: false),
    UtilItem(utility: Utilities.PRIVATE, isChecked: false),
    UtilItem(utility: Utilities.LOFT, isChecked: false),
    UtilItem(utility: Utilities.PET, isChecked: false),
    UtilItem(utility: Utilities.BED, isChecked: false),
    UtilItem(utility: Utilities.WARDROBE, isChecked: false),
    UtilItem(utility: Utilities.AIR_CONDITIONER, isChecked: false)
  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      width: double.infinity,
      margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: ListView(
        children: [
          Text(
            'Thông tin hình ảnh và tiện ích',
            style: TextStyle(
                color: primary40, fontSize: 18, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 20,
          ),

          //---------------------Image-------------------------
          Text(
            'HÌNH ẢNH',
            style: TextStyle(
                color: secondary40, fontSize: 16, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            child: DottedBorder(
                borderType: BorderType.RRect,
                radius: Radius.circular(10),
                dashPattern: [2, 2],
                color: secondary40,
                child: SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(50, 20, 50, 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Icon(
                          Icons.add_photo_alternate_outlined,
                          size: 52,
                          color: primary60,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Bấm vào đây để đăng hình ảnh từ thư viện nhé!',
                          softWrap: true,
                          maxLines: 2,
                          style: TextStyle(
                              color: primary60,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                )),
          ),
          SizedBox(
            height: 16,
          ),

          //---------------------Utilities-------------------------
          Text(
            'TIỆN ÍCH',
            style: TextStyle(
                color: secondary40, fontSize: 16, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 10,
          ),
          GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 3,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
            ),
            itemCount: utilList.length,
            itemBuilder: (context, index) {
              return FilledButton.icon(
                style: FilledButton.styleFrom(
                  padding: EdgeInsets.all(0),
                  backgroundColor:
                      utilList[index].isChecked ? primary98 : secondary90,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    utilList[index] = utilList[index]
                        .copyWith(isChecked: !utilList[index].isChecked);
                  });
                },
                icon: Icon(
                  utilList[index].utility.getIconUtil(),
                  size: 20,
                  color: utilList[index].isChecked ? primary40 : secondary40,
                ),
                label: Text(
                  utilList[index].utility.getNameUtil(),
                  style: TextStyle(
                      fontSize: 12,
                      color:
                          utilList[index].isChecked ? primary40 : secondary40,
                      fontWeight: FontWeight.w500),
                ),
              );
            },
          ),
          SizedBox(
            height: 16,
          ),
        ],
      ),
    ));
  }
}
