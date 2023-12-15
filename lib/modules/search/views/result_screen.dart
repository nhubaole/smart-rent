// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:smart_rent/modules/search/views/filter_screen.dart';
// import 'package:smart_rent/modules/search/views/result_item.dart';

// import '../../../core/values/app_colors.dart';
// import '../controllers/filter_controller.dart';

// // ignore: must_be_immutable
// class ResultScreen extends StatelessWidget {
//   ResultScreen({super.key, required this.location});

//   final String location;
//   FilterController controller = Get.put(FilterController());
//   List<String> filterList = [
//     "Giá cả",
//     "Tiện ích",
//     "Loại phòng",
//     "Số người",
//     "Sắp xếp"
//   ];

//   @override
//   Widget build(BuildContext context) {
//     controller.setLocation(location);
//     return AnnotatedRegion<SystemUiOverlayStyle>(
//         value: const SystemUiOverlayStyle(
//           statusBarColor: Colors.transparent,
//           statusBarBrightness: Brightness.light,
//           statusBarIconBrightness: Brightness.dark,
//         ),
//         child: Scaffold(
//             body: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   const SizedBox(
//                     height: 24,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Container(
//                           padding: const EdgeInsets.symmetric(
//                               vertical: 10, horizontal: 10),
//                           width: MediaQuery.sizeOf(context).width - 80,
//                           decoration: BoxDecoration(
//                               border: Border.all(color: primary60, width: 1),
//                               borderRadius: BorderRadius.circular(4),
//                               color: Colors.white),
//                           child: Row(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               SvgPicture.asset('assets/images/ic_location.svg'),
//                               const SizedBox(
//                                 width: 8,
//                               ),
//                               Expanded(
//                                 child: Text(
//                                   controller.location,
//                                   style: const TextStyle(
//                                       fontSize: 12,
//                                       fontWeight: FontWeight.w600,
//                                       color: primary60),
//                                 ),
//                               ),
//                             ],
//                           )),
//                       const SizedBox(
//                         width: 16,
//                       ),
//                       InkWell(
//                         onTap: () {
//                           Get.back();
//                         },
//                         child: const Text(
//                           'Hủy',
//                           style: TextStyle(
//                               fontSize: 14,
//                               color: primary60,
//                               fontWeight: FontWeight.bold),
//                         ),
//                       )
//                     ],
//                   ),
//                   const SizedBox(
//                     height: 16,
//                   ),
//                   SizedBox(
//                     height: 36,
//                     child: ListView.separated(
//                       scrollDirection: Axis.horizontal,
//                       itemBuilder: (context, index) {
//                         return FilledButton.icon(
//                           style: FilledButton.styleFrom(
//                             padding: const EdgeInsets.symmetric(horizontal: 10),
//                             backgroundColor: secondary90,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(4),
//                             ),
//                           ),
//                           onPressed: () {
//                             Get.to(FilterScreen());
//                           },
//                           icon: const Icon(
//                             Icons.keyboard_arrow_down,
//                             size: 20,
//                             color: secondary40,
//                           ),
//                           label: Text(
//                             filterList[index],
//                             style: const TextStyle(
//                                 fontSize: 12,
//                                 color: secondary40,
//                                 fontWeight: FontWeight.w500),
//                           ),
//                         );
//                       },
//                       itemCount: filterList.length,
//                       separatorBuilder: (BuildContext context, int index) {
//                         return const SizedBox(width: 8);
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Obx(() => controller.filterStringList.isNotEmpty
//                 ? Container(
//                     height: 50,
//                     color: secondary90,
//                     child: Row(
//                       children: [
//                         const SizedBox(
//                           width: 10,
//                         ),
//                         const Text(
//                           "Bộ lọc",
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 16,
//                               color: secondary20),
//                         ),
//                         const SizedBox(
//                           width: 10,
//                         ),
//                         Expanded(
//                             child: Obx(
//                           () => ListView.separated(
//                             scrollDirection: Axis.horizontal,
//                             padding: const EdgeInsets.symmetric(vertical: 8),
//                             itemBuilder: (context, index) {
//                               return Container(
//                                   padding: const EdgeInsets.all(8),
//                                   decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(10),
//                                       color: Colors.white),
//                                   child: Row(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.center,
//                                     children: [
//                                       Obx(() => Text(
//                                             controller.filterStringList[index]
//                                                 .keys.first,
//                                             style: const TextStyle(
//                                                 fontWeight: FontWeight.bold,
//                                                 fontSize: 12,
//                                                 color: secondary40),
//                                           )),
//                                       const SizedBox(
//                                         width: 10,
//                                       ),
//                                       InkWell(
//                                         onTap: () {
//                                           controller.removeFilter(controller
//                                               .filterStringList[index]);
//                                         },
//                                         child: Icon(
//                                           Icons.cancel,
//                                           color: secondary40,
//                                           size: 16,
//                                         ),
//                                       )
//                                     ],
//                                   ));
//                             },
//                             itemCount: controller.itemFilterCount.value,
//                             separatorBuilder:
//                                 (BuildContext context, int index) {
//                               return const SizedBox(width: 8);
//                             },
//                           ),
//                         ))
//                       ],
//                     ))
//                 : SizedBox()),
//             Obx(() => SizedBox(
//                   height: controller.filterStringList.isNotEmpty ? 16 : 0,
//                 )),
//             Obx(
//               () => Padding(
//                 padding: const EdgeInsets.only(left: 20),
//                 child: Text(
//                   controller.isLoaded.value
//                       ? "${controller.results.value.length} Kết quả"
//                       : "",
//                   style: const TextStyle(
//                       color: secondary20,
//                       fontWeight: FontWeight.w600,
//                       fontSize: 20),
//                 ),
//               ),
//             ),
//             const SizedBox(
//               height: 16,
//             ),
//             Expanded(
//                 child: Container(
//                     width: double.infinity,
//                     color: primary95,
//                     padding: const EdgeInsets.symmetric(horizontal: 20),
//                     child: Obx(() => ListView.builder(
//                           itemCount: controller.results.value.length,
//                           itemBuilder: (context, index) {
//                             return Padding(
//                               padding: const EdgeInsets.only(bottom: 16),
//                               child: ResultItem(
//                                 room: controller.results.value[index],
//                               ),
//                             );
//                           },
//                         ))))
//           ],
//         )));
//   }
// }
