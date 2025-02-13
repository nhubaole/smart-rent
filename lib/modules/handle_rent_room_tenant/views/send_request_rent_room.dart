import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:smart_rent/core/model/room/room_model.dart';
import '../../../core/config/app_colors.dart';
import '/core/widget/button_fill.dart';
import '/core/widget/date_input_form_field.dart';
import '/modules/handle_rent_room_tenant/controllers/send_request_rent_room_controller.dart';

// ignore: must_be_immutable
class SendRequestRentRoom extends StatelessWidget {
  SendRequestRentRoom({
    super.key,
    required this.room,
    this.result,
  });
  Map<String, dynamic>? result;
  final RoomModel room;
  late double deviceHeight;
  late double deviceWidth;

  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
    var date = DateTime.fromMillisecondsSinceEpoch(1 * 1000);
    DateFormat('HH:mm dd/MM/yyyy').format(date);
    final sendRequestController = Get.put(
      SendRequestRentRoomController(
        room: room,
        result: result,
      ),
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary98,
        title: const Text(
          'Gửi yêu cầu thuê phòng',
          style: TextStyle(
            color: AppColors.primary40,
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            right: deviceWidth * 0.05,
            left: deviceWidth * 0.05,
            top: deviceHeight * 0.02,
            bottom: deviceHeight * 0.08,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Form(
                key: sendRequestController.formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Yêu cầu thuê phòng',
                      style: TextStyle(
                        color: AppColors.primary40,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: deviceHeight * 0.01,
                    ),
                    const Text(
                      'GIÁ ĐỀ XUẤT',
                      style: TextStyle(
                        color: AppColors.secondary40,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: deviceHeight * 0.005,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng nhập số';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller:
                          sendRequestController.priceSuggestTextController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Nhập giá đề xuất cho chủ phòng',
                        suffixText: '| VNĐ',
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.secondary60,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'SỐ NGƯỜI DỰ ĐỊNH Ở CÙNG',
                      style: TextStyle(
                        color: AppColors.secondary40,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: deviceHeight * 0.005,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng nhập số';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller:
                          sendRequestController.quantityPeopleTextController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Nhập số người/phòng',
                        suffixText: '| người/phòng',
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.secondary60,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'NGÀY BẮT ĐẦU THUÊ',
                      style: TextStyle(
                        color: AppColors.secondary40,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: deviceHeight * 0.005,
                    ),
                    Obx(
                      () => SwitchListTile(
                        value: sendRequestController.isJoinNow.value,
                        activeColor: Colors.white,
                        activeTrackColor: AppColors.primary60,
                        controlAffinity: ListTileControlAffinity.leading,
                        contentPadding: const EdgeInsets.only(
                          left: 0,
                        ),
                        onChanged: (value) {
                          sendRequestController.isJoinNow.value = value;
                        },
                        title: const Text(
                          'Có thể dọn vào ở ngay',
                          style: TextStyle(
                            color: AppColors.primary40,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    Obx(
                      () => !sendRequestController.isJoinNow.value
                          ? DateInputField(
                              firstDate: DateTime.now().year,
                              lastDate: DateTime.now().year + 1,
                              borderRadius: BorderRadius.circular(8),
                              borderWidth: 1,
                              borderColor: AppColors.secondary20,
                              textEditingController:
                                  sendRequestController.dateJoinTextController,
                              labelText: 'Ngày nhận phòng',
                              hintText: DateFormat('dd/MM/yyyy')
                                  .format(DateTime.now())
                                  .toString(),
                              icon: Icons.timelapse_outlined,
                              onDateSelected: (DateTime selectedDate) {
                                sendRequestController
                                        .dateJoinTextController.text =
                                    DateFormat('dd/MM/yyyy')
                                        .format(selectedDate)
                                        .toString();
                              },
                              onValidate: (value) {
                                if (!sendRequestController.isDate(value!)) {
                                  return 'Vui lòng nhập ngày vào nhận phòng';
                                }
                                return null;
                              },
                            )
                          : const SizedBox(),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'NGÀY KẾT THÚC THUÊ',
                      style: TextStyle(
                        color: AppColors.secondary40,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: deviceHeight * 0.005,
                    ),
                    Obx(
                      () => SwitchListTile(
                        value: sendRequestController.isLeave.value,
                        activeColor: Colors.white,
                        activeTrackColor: AppColors.primary60,
                        controlAffinity: ListTileControlAffinity.leading,
                        contentPadding: const EdgeInsets.only(
                          left: 0,
                        ),
                        onChanged: (value) {
                          sendRequestController.isLeave.value = value;
                        },
                        title: const Text(
                          'Chưa xác định ngày trả phòng',
                          style: TextStyle(
                            color: AppColors.primary40,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    Obx(
                      () => !sendRequestController.isLeave.value
                          ? DateInputField(
                              firstDate: DateTime.now().year,
                              lastDate: DateTime.now().year + 1,
                              borderRadius: BorderRadius.circular(8),
                              borderWidth: 1,
                              borderColor: AppColors.secondary20,
                              textEditingController:
                                  sendRequestController.dateLeaveTextController,
                              labelText: 'Ngày trả phòng trong tương lai',
                              hintText: DateFormat('dd/MM/yyyy')
                                  .format(DateTime.now())
                                  .toString(),
                              icon: Icons.timelapse_outlined,
                              onDateSelected: (DateTime selectedDate) {
                                sendRequestController
                                        .dateLeaveTextController.text =
                                    DateFormat('dd/MM/yyyy')
                                        .format(selectedDate)
                                        .toString();
                              },
                              onValidate: (value) {
                                if (!sendRequestController.isDate(value!)) {
                                  return 'Vui lòng nhập ngày trả phòng trong tương lai';
                                }
                                return null;
                              },
                            )
                          : const SizedBox(),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'YÊU CẦU ĐẶC BIỆT',
                style: TextStyle(
                  color: AppColors.secondary40,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: deviceHeight * 0.005,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.003),
                child: TextField(
                  controller:
                      sendRequestController.specialRequestTextController,
                  onChanged: (value) {},
                  decoration: InputDecoration(
                    hintText: 'Nhập yêu cầu đặc biệt của bạn',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(deviceWidth * 0.001),
                      ),
                      borderSide: const BorderSide(
                        color: Colors.white,
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: AppColors.secondary20,
                        width: 1,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: AppColors.secondary20,
                        width: 1,
                      ),
                    ),
                  ),
                  minLines: 3,
                  maxLines: 6,
                  keyboardType: TextInputType.multiline,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Thông tin cá nhân',
                style: TextStyle(
                  color: AppColors.primary40,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: deviceHeight * 0.005,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: deviceWidth * 0.01,
                ),
                child: const Text(
                  'Bằng việc gửi yêu cầu thuê phòng, chủ phòng có thể nhìn thấy các thông tin cá nhân của bạn',
                  style: TextStyle(
                    color: AppColors.secondary40,
                    fontSize: 16,
                    textBaseline: TextBaseline.alphabetic,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ButtonFill(
                    onPressed: () {
                      sendRequestController.sendRequest(room);
                    },
                    icon: const Icon(
                      CupertinoIcons.location_fill,
                      size: 20,
                      color: Colors.white,
                    ),
                    text: const Text(
                      'Gửi yêu cầu',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                    backgroundColor: AppColors.primary60,
                    borderRadius: BorderRadius.circular(100)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
