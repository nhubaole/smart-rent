import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_rent/modules/search/controllers/result_controller.dart';
import 'package:smart_rent/modules/search/views/result_item.dart';

import '../../../core/values/app_colors.dart';

class ResultScreen extends StatelessWidget {
  ResultScreen({super.key, required this.location});
  final String location;
  ResultController controller = Get.put(ResultController());

  @override
  Widget build(BuildContext context) {
    controller.setLocation(location);
    return Scaffold(
        body: Column(
      children: [
        Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                      width: MediaQuery.sizeOf(context).width - 80,
                      decoration: BoxDecoration(
                          border: Border.all(color: primary60, width: 1),
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white),
                      child: Text(
                        location,
                        style: TextStyle(
                            color: primary60,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      )),
                  SizedBox(
                    width: 16,
                  ),
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Text(
                      'Hủy',
                      style: TextStyle(
                          fontSize: 16,
                          color: primary60,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Obx(
                () => Text(
                  controller.isLoaded.value
                      ? "${controller.results.value.length} Kết quả"
                      : "",
                  style: TextStyle(
                      color: secondary20,
                      fontWeight: FontWeight.w600,
                      fontSize: 20),
                ),
              )
            ],
          ),
        ),
        Expanded(
            child: Container(
                width: double.infinity,
                color: primary95,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Obx(() => ListView.builder(
                      itemCount: controller.results.value.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 16),
                          child: ResultItem(
                            room: controller.results.value[index],
                          ),
                        );
                      },
                    ))))
      ],
    ));
  }
}
