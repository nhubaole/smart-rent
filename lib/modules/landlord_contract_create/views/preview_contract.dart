import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/core/extension/datetime_extension.dart';
import 'package:smart_rent/core/extension/double_extension.dart';
import 'package:smart_rent/modules/landlord_contract_create/landlord_contract_create_controller.dart';

class PreviewContract extends GetView<LandlordContractCreateController> {
  const PreviewContract({super.key});

  static TextStyle childTextStyle = TextStyle(
    fontSize: 14.sp,
    color: AppColors.secondary40,
    fontWeight: FontWeight.w400,
  );

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.only(
          right: 16.px,
          left: 16.px,
          bottom: MediaQuery.of(context).viewInsets.bottom + 10.px),
      child: Column(
        children: [
          _buildHeader(),
          SizedBox(height: 8.px),
          _buildPreviewContract(),
        ],
      ),
    );
  }

  Widget _buildPreviewContract() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8.px),
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(
              right: 8.px,
              left: 8.px,
              top: 32.px,
              bottom: 32.px,
            ),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(8.px),
              border: Border.all(width: 1, color: AppColors.secondary80),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildNationalTitle(),
                SizedBox(height: 8.px),
                _buildMotto(),
                SizedBox(height: 8.px),
                _builtTitleContract(),
                SizedBox(height: 8.px),
                _buildText(
                  text:
                      'Số: ${controller.contractByIdModel?.id ?? '...'}/HĐTNO',
                  alignment: Alignment.center,
                ),
                // SizedBox(height: 8.px),
                // _buildText(
                //     text:
                //         '- Căn cứ hợp đồng thuê số ${controller.contractByIdModel?.id} đã ký ngày ${controller.contractByIdModel?.startDate?.ddMMyyyy}'),
                // SizedBox(height: 8.px),
                // _buildText(
                //     text:
                //         '- Căn cứ phụ lục hợp đồng số ${controller.contractByIdModel?.id} đã ký ngày ${controller.contractByIdModel?.startDate?.ddMMyyyy}'),
                // SizedBox(height: 8.px),
                // _buildText(text: '- Căn cứ nhu cầu và khả năng của hai bên.'),
                SizedBox(height: 8.px),
                _buildText(
                    text:
                        'Hôm nay, ngày ${controller.contractByIdModel?.dateCreated?.ddMMyyyy ?? DateTime.now().ddMMyyyy}, tại ${controller.contractByIdModel?.addressCreated ?? '...'}. Chúng tôi gồm có:'),
                // SizedBox(height: 8.px),
                // _buildText(
                //     text:
                //         'Thỏa thuận dưới đây được thành lập giữa các bên bao gồm:'),
                SizedBox(height: 8.px),
                _buildText(
                  text: 'BÊN CHO THUÊ (BÊN A):',
                  textStyle: childTextStyle.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.px),
                _buildText(
                    text:
                        'Ông/bà: ${controller.contractByIdModel?.partyA?.name ?? controller.user.fullName ?? '..'}, Năm sinh: ${controller.contractByIdModel?.partyA?.dob?.ddMMyyyy ?? controller.user.dob?.ddMMyyyy ?? '...'}'),
                _buildText(
                    text:
                        'CMND/CCCD số: ${controller.contractByIdModel?.partyA?.cccd ?? '...'}, Cấp ngày: ${controller.contractByIdModel?.partyA?.issueDate?.ddMMyyyy ?? '...'}, Nơi cấp: ${controller.contractByIdModel?.partyA?.registeredPlace ?? '...'}'),
                _buildText(text: 'Địa chỉ: ${controller.user.address}'),
                _buildText(text: 'Điện thoại: ${controller.user.phoneNumber}'),
                _buildText(
                    text:
                        'Là chủ sỡ hữu nhà ở: ${controller.contractByIdModel?.roomAddress?.join(', ') ?? '...'}'),
                _buildText(
                    text:
                        'Các chứng từ sở hữu và tham khảo về nhà ở đã được cơ quan có thẩm quyền cấp cho Bên A gồm có:'),
                _buildText(
                    text:
                        '................................................................'),
                _buildText(
                    text:
                        '................................................................'),
                _buildText(
                  text: 'BÊN THUÊ (BÊN B):',
                  textStyle: childTextStyle.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildText(
                    text:
                        'Ông/bà: ${controller.contractByIdModel?.partyB?.name ?? controller.rentalRequestById.sender?.fullName ?? '...'}, Sinh ngày: ${controller.contractByIdModel?.partyB?.dob?.ddMMyyyy ?? controller.rentalRequestById.sender?.dob?.ddMMyyyy ?? '...'}'),
                _buildText(
                    text:
                        'CMND số: ${controller.contractByIdModel?.partyB?.cccd ?? '...'}, Cấp ngày: ${controller.contractByIdModel?.partyB?.issueDate?.ddMMyyyy ?? '...'}, Nơi cấp: ${controller.contractByIdModel?.partyB?.registeredPlace ?? '...'}'),
                _buildText(
                    text:
                        'Hộ khẩu: ${controller.rentalRequestById.sender?.address ?? '...'}'),
                _buildText(
                    text:
                        'Điện thoại: ${controller.rentalRequestById.sender?.phoneNumber ?? '...'}, Fax:....'),
                _buildText(
                    text:
                        'Mã số thuế:............................................................'),
                // _buildText(
                //     text:
                //         'Căn cứ theo Giấy chứng nhận quyền sở hữu nhà ở và quyền sử dụng đất ở: Số @@@@ do @@@ cấp ngày @@/@@/@@'),
                // SizedBox(height: 8.px),
                _buildText(
                    text:
                        'Tài khoản số: ${controller.rentalRequestById.sender?.bankInfo?.accountNumber ?? '...'}, Mở tại ngân hàng: ${controller.rentalRequestById.sender?.bankInfo?.bankName ?? '...'}'),
                _buildText(
                    textStyle:
                        childTextStyle.copyWith(fontWeight: FontWeight.bold),
                    text:
                        'Hai bên cùng thỏa thuận ký hợp đồng với những nội dung sau:'),
                _buildText(
                  text: 'ĐIỀU 1: ĐỐI TƯỢNG CỦA HỢP ĐỒNG',
                  textStyle: childTextStyle.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildText(
                  text:
                      'Bên A đồng ý cho Bên B thuê căn hộ (căn nhà) tại địa chỉ ${controller.contractByIdModel?.roomAddress?.join(', ') ?? '...'}, thuộc sở hữu hợp pháp của Bên A',
                ),
                _buildText(text: 'Chi tiết căn hộ như sau'),
                _buildText(
                    text:
                        'Bao gồm: Ban công, hệ thống điện nước đã sẵn sàng sử dụng được, các bóng đèn trong các phòng và hệ thông công tắc, các bồn rửa mặt, bồn vệ sinh đều sử dụng tốt'),
                _buildText(
                  text: 'ĐIỀU 2. GIÁ CHO THUÊ NHÀ Ở VÀ PHƯƠNG THỨC THANH TOÁN',
                  textStyle: childTextStyle.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildText(
                    text:
                        '2.1. Giá cho thuê nhà ở là ${controller.contractByIdModel?.roomPrice?.toStringTotalPrice ?? controller.rentalRequestById.room?.totalPrice?.toStringTotalPrice ?? '...'} đồng/ tháng. Giá cho thuê này đã baop gồm các chi phí về quản lý, bảo trì và vận hành nhà ở.'),
                _buildText(
                    text:
                        '2.2. Các chi phí sử dụng điện, nước, điện thoại và các dịch vụ khác do bên B thanh toán cho bên cung cấp điện, nước, điện thoại và các cơ quan quản lý dịch vụ.'),
                _buildText(
                    text:
                        '2.3. Phương thức thanh toán: ${controller.contractByIdModel?.method ?? controller.paymentMethodController.text}, trả vào ngày ${controller.formDatePaidPerMonthController.text} hàng tháng.'),
                _buildText(
                  text: 'ĐIỀU 3. THỜI HẠN THUÊ VÀ THỜI ĐIỂM GIAO NHẬN NHÀ Ở',
                  textStyle: childTextStyle.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildText(
                    text:
                        '3.1. Thời hạn thuê ngôi nhà nêu trên là ${int.tryParse((DatetimeExt.convertToDate(controller.toDateController.text).difference(DatetimeExt.convertToDate(controller.fromDateController.text)).inDays / 360).toString()) ?? 0} năm kể từ ngày ${DatetimeExt.convertToDate(controller.fromDateController.text).day} tháng ${DatetimeExt.convertToDate(controller.fromDateController.text).month} năm ${DatetimeExt.convertToDate(controller.fromDateController.text).year}'),
                _buildText(
                    text:
                        '3.2. Thời điểm giao nhận nhà ở là ngày ${DatetimeExt.convertToDate(controller.fromDateController.text).day} tháng ${DatetimeExt.convertToDate(controller.fromDateController.text).month} năm ${DatetimeExt.convertToDate(controller.fromDateController.text).year}'),
                _buildText(
                  text: 'ĐIỀU 4. NGHĨA VỤ VÀ QUYỀN CỦA BÊN A',
                  textStyle: childTextStyle.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildText(text: '4.1. Nghĩa vụ của bên A:'),
                _buildText(
                    text:
                        'a) Giao nhà ở và trang thiết bị gắn liền với nhà ở (nếu có) cho bên B theo đúng hợp đồng;'),
                _buildText(
                    text:
                        'b) Phổ biến cho bên B quy định về quản lý sử dụng nhà ở;'),
                _buildText(
                    text:
                        'c) Bảo đảm cho bên B sử dụng ổn định nhà trong thời hạn thuê;'),
                _buildText(
                    text:
                        'd) Bảo dưỡng, sửa chữa nhà theo định kỳ hoặc theo thỏa thuận; nếu bên A không bảo dưỡng, sửa chữa nhà mà gây thiệt hại cho bên B, thì phải bồi thường;'),
                _buildText(
                    text:
                        'e) Tạo điều kiện cho bên B sử dụng thuận tiện diện tích thuê;'),
                _buildText(
                    text: 'f) Nộp các khoản thuế về nhà và đất (nếu có);'),
                _buildText(
                    text:
                        'g) Hướng dẫn, đôn đốc bên B thực hiện đúng các quy định về đăng ký tạm trú.'),
                SizedBox(height: 8.px),
                _buildText(text: '4.2. Quyền của bên A:'),
                SizedBox(height: 8.px),
                _buildText(
                    text:
                        'a) Yêu cầu bên B trả đủ tiền thuê nhà đúng kỳ hạn như đã thỏa thuận;'),
                _buildText(
                    text:
                        'b) Trường hợp chưa hết hạn hợp đồng mà bên A cải tạo nhà ở và được bên B đồng ý thì bên A được quyền điều chỉnh giá cho thuê nhà ở. Giá cho thuê nhà ở mới do các bên thoả thuận; trong trường hợp không thoả thuận được thì bên A có quyền đơn phương chấm dứt hợp đồng thuê nhà ở và phải bồi thường cho bên B theo quy định của pháp luật;'),
                _buildText(
                    text:
                        'c) Yêu cầu bên B có trách nhiệm trong việc sửa chữa phần hư hỏng, bồi thường thiệt hại do lỗi của bên B gây ra;'),
                _buildText(
                    text:
                        'd) Cải tạo, nâng cấp nhà cho thuê khi được bên B đồng ý, nhưng không được gây phiền hà cho bên B sử dụng chỗ ở;'),
                _buildText(
                    text:
                        'e) Được lấy lại nhà cho thuê khi hết hạn hợp đồng thuê, nếu hợp đồng không quy định thời hạn thuê thì bên cho thuê muốn lấy lại nhà phải báo cho bên thuê biết trước ........ ngày;'),
                _buildText(
                    text:
                        'f) Đơn phương chấm dứt thực hiện hợp đồng thuê nhà nhưng phải báo cho bên B biết trước ít nhất ......ngày nếu không có thỏa thuận khác và yêu cầu bồi thường thiệt hại nếu bên B có một trong các hành vi sau đây:'),
                _buildText(
                    text:
                        '- Không trả tiền thuê nhà liên tiếp trong ...... trở lên mà không có lý do chính đáng;'),
                _buildText(
                    text:
                        '- Sử dụng nhà không đúng mục đích thuê như đã thỏa thuận trong hợp đồng;'),
                _buildText(
                    text:
                        '- Tự ý đục phá, cơi nới, cải tạo, phá dỡ nhà ở đang thuê;'),
                _buildText(
                    text:
                        '- Bên B chuyển đổi, cho mượn, cho thuê lại nhà ở đang thuê mà không có sự đồng ý của bên A;'),
                _buildText(
                    text:
                        '- Làm mất trật tự, vệ sinh môi trường, ảnh hưởng nghiêm trọng đến sinh hoạt của những người xung quanh đã được bên A hoặc tổ trưởng tổ dân phố nhắc nhở mà vẫn không khắc phục;'),
                _buildText(
                    text:
                        '- Thuộc trường hợp khác theo quy định của pháp luật.'),
                SizedBox(height: 16.px),

                _buildText(
                  text: 'ĐIỀU 5. NGHĨA VỤ VÀ QUYỀN CỦA BÊN B',
                  textStyle: childTextStyle.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.px),
                _buildText(text: '5.1. Nghĩa vụ của bên B:'),
                SizedBox(height: 8.px),
                _buildText(
                    text:
                        'a) Sử dụng nhà đúng mục đích đã thỏa thuận, giữ gìn nhà ở và có trách nhiệm trong việc sửa chữa những hư hỏng do mình gây ra;'),
                _buildText(
                    text: 'b) Trả đủ tiền thuê nhà đúng kỳ hạn đã thỏa thuận;'),
                _buildText(
                    text:
                        'c) Trả tiền điện, nước, điện thoại, vệ sinh và các chi phí phát sinh khác trong thời gian thuê nhà;'),
                _buildText(text: 'd) Trả nhà cho bên A theo đúng thỏa thuận.'),
                _buildText(
                    text:
                        'e) Chấp hành đầy đủ những quy định về quản lý sử dụng nhà ở;'),
                _buildText(
                    text:
                        'f) Không được chuyển nhượng hợp đồng thuê nhà hoặc cho người khác thuê lại trừ trường hợp được bên A đồng ý bằng văn bản;'),
                _buildText(
                    text:
                        'g) Chấp hành các quy định về giữ gìn vệ sinh môi trường và an ninh trật tự trong khu vực cư trú;'),
                _buildText(
                    text:
                        'h) Giao lại nhà cho bên A trong các trường hợp chấm dứt hợp đồng.'),
                SizedBox(height: 8.px),
                _buildText(text: '5.2. Quyền của bên B:'),
                SizedBox(height: 8.px),
                _buildText(
                    text:
                        'a) Nhận nhà ở và trang thiết bị gắn liền (nếu có) theo đúng thoả thuận;'),
                _buildText(
                    text:
                        'b) Được đổi nhà đang thuê với bên thuê khác, nếu được bên A đồng ý bằng văn bản;'),
                _buildText(
                    text:
                        'c) Được cho thuê lại nhà đang thuê, nếu được bên cho thuê đồng ý bằng văn bản;'),
                _buildText(
                    text:
                        'd) Được thay đổi cấu trúc ngôi nhà nếu được bên A đồng ý bằng văn bản;'),
                _buildText(
                    text:
                        'e) Yêu cầu bên A sửa chữa nhà đang cho thuê trong trường hợp nhà bị hư hỏng nặng;'),
                _buildText(
                    text:
                        'g) Được ưu tiên ký hợp đồng thuê tiếp, nếu đã hết hạn thuê mà nhà vẫn dùng để cho thuê;'),
                _buildText(
                    text:
                        'h) Được ưu tiên mua nhà đang thuê, khi bên A thông báo về việc bán ngôi nhà;'),
                _buildText(
                    text:
                        'i) Đơn phương chấm dứt thực hiện hợp đồng thuê nhà nhưng phải báo cho bên A biết trước ít nhất 30 ngày nếu không có thỏa thuận khác và yêu cầu bồi thường thiệt hại nếu bên A có một trong các hành vi sau đây:'),
                _buildText(text: '- Không sửa chữa nhà ở khi có hư hỏng nặng;'),
                _buildText(
                    text:
                        '- Tăng giá thuê nhà ở bất hợp lý hoặc tăng giá thuê mà không thông báo cho bên thuê nhà ở biết trước theo thỏa thuận;'),
                _buildText(
                    text:
                        '- Quyền sử dụng nhà ở bị hạn chế do lợi ích của người thứ ba.'),
                SizedBox(height: 16.px),

                _buildText(
                  text: 'ĐIỀU 6. QUYỀN TIẾP TỤC THUÊ NHÀ Ở',
                  textStyle: childTextStyle.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.px),
                _buildText(
                    text:
                        '6.1. Trường hợp chủ sở hữu nhà ở chết mà thời hạn thuê nhà ở vẫn còn thì bên B được tiếp tục thuê đến hết hạn hợp đồng. Người thừa kế có trách nhiệm tiếp tục thực hiện hợp đồng thuê nhà ở đã ký kết trước đó, trừ trường hợp các bên có thỏa thuận khác. Trường hợp chủ sở hữu không có người thừa kế hợp pháp theo quy định của pháp luật thì nhà ở đó thuộc quyền sở hữu của Nhà nước và người đang thuê nhà ở được tiếp tục thuê theo quy định về quản lý, sử dụng nhà ở thuộc sở hữu nhà nước.'),
                _buildText(
                    text:
                        '6.2. Trường hợp chủ sở hữu nhà ở chuyển quyền sở hữu nhà ở đang cho thuê cho người khác mà thời hạn thuê nhà ở vẫn còn thì bên B được tiếp tục thuê đến hết hạn hợp đồng; chủ sở hữu nhà ở mới có trách nhiệm tiếp tục thực hiện hợp đồng thuê nhà ở đã ký kết trước đó, trừ trường hợp các bên có thỏa thuận khác.'),
                _buildText(
                    text:
                        '6.3. Khi bên B chết mà thời hạn thuê nhà ở vẫn còn thì người đang cùng sinh sống với bên B được tiếp tục thuê đến hết hạn hợp đồng thuê nhà ở, trừ trường hợp thuê nhà ở công vụ hoặc các bên có thỏa thuận khác hoặc pháp luật có quy định khác.'),
                SizedBox(height: 16.px),

                _buildText(
                  text: 'ĐIỀU 7. TRÁCH NHIỆM DO VI PHẠM HỢP ĐỒNG',
                  textStyle: childTextStyle.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.px),
                _buildText(
                    text:
                        'Trong quá trình thực hiện hợp đồng mà phát sinh tranh chấp, các bên cùng nhau thương lượng giải quyết; trong trường hợp không tự giải quyết được, cần phải thực hiện bằng cách hòa giải; nếu hòa giải không thành thì đưa ra Tòa án có thẩm quyền theo quy định của pháp luật.'),
                SizedBox(height: 16.px),

                _buildText(
                  text: 'ĐIỀU 8. CÁC THỎA THUẬN KHÁC',
                  textStyle: childTextStyle.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.px),
                _buildText(
                    text:
                        '8.1. Việc sửa đổi, bổ sung hoặc hủy bỏ hợp đồng này phải lập thành văn bản mới có giá trị để thực hiện.'),
                SizedBox(height: 8.px),
                _buildText(
                    text:
                        '8.2. Việc chấm dứt hợp đồng thuê nhà ở được thực hiện khi có một trong các trường hợp sau đây:'),
                _buildText(
                    text:
                        'a) Hợp đồng thuê nhà ở hết hạn; trường hợp trong hợp đồng không xác định thời hạn thì hợp đồng chấm dứt sau 90 ngày, kể từ ngày bên A thông báo cho bên B biết việc chấm dứt hợp đồng;'),
                _buildText(text: 'b) Nhà ở cho thuê không còn;'),
                _buildText(
                    text:
                        'c) Nhà ở cho thuê bị hư hỏng nặng, có nguy cơ sập đổ hoặc thuộc khu vực đã có quyết định thu hồi đất, giải tỏa nhà ở hoặc có quyết định phá dỡ của cơ quan nhà nước có thẩm quyền; nhà ở cho thuê thuộc diện bị Nhà nước trưng mua, trưng dụng để sử dụng vào các mục đích khác.'),
                _buildText(
                    text:
                        'Bên A phải thông báo bằng văn bản cho bên B biết trước 30 ngày về việc chấm dứt hợp đồng thuê nhà ở quy định tại điểm này, trừ trường hợp các bên có thỏa thuận khác;'),
                _buildText(
                    text:
                        'd) Hai bên thoả thuận chấm dứt hợp đồng trước thời hạn;'),
                _buildText(
                    text:
                        'e) Bên B chết hoặc có tuyên bố mất tích của Tòa án mà khi chết, mất tích không có ai đang cùng chung sống;'),
                _buildText(
                    text:
                        'f) Chấm dứt khi một trong các bên đơn phương chấm dứt thực hiện hợp đồng thuê nhà ở.'),

                SizedBox(height: 8.px),
                _buildText(
                  text: 'ĐIỀU 9. CAM KẾT CỦA CÁC BÊN',
                  textStyle: childTextStyle.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildText(
                    text:
                        'Bên A và bên B chịu trách nhiệm trước pháp luật về những lời cùng cam kết sau đây:'),
                _buildText(
                    text:
                        '9.1. Đã khai đúng sự thật và tự chịu trách nhiệm về tính chính xác của những thông tin về nhân thân đã ghi trong hợp đồng này.'),
                _buildText(
                    text:
                        '9.2. Thực hiện đúng và đầy đủ tất cả những thỏa thuận đã ghi trong hợp đồng này; nếu bên nào vi phạm mà gây thiệt hại, thì phải bồi thường cho bên kia hoặc cho người thứ ba (nếu có).'),
                _buildText(
                    text:
                        'Trong quá trình thực hiện nếu phát hiện thấy những vấn đề cần thoả thuận thì hai bên có thể lập thêm Phụ lục hợp đồng. Nội dung Phụ lục hợp đồng có giá trị pháp lý như hợp đồng chính.'),
                _buildText(
                    text:
                        '9.3. Hợp đồng này có giá trị kể từ ngày hai bên ký kết.'),
                _buildText(
                    text:
                        'Hợp đồng được lập thành 2 bản, mỗi bên giữ một bản và có giá trị như nhau.'),
                SizedBox(height: 8.px),
                // OLD VERSION
                // _buildText(
                //     text:
                //         '1. Gia hạn thời gian thuê: từ ngày ${controller.formDateController.text} đến hết ngày ${controller.toDateController.text}. Sau thời hạn gia hạn này, nếu Bên B tiếp tục thuê thì phảo thông báo cho Bên A chậm nhất là @@ trước khi chấm dứt hợp động thuê. Nếu Bên A đồng ý thì các bên sẽ thỏa thuận tiếp tục gia hạn bằng phụ lục hợp đồng khác hoặc ký một hợp đồng mới theo thỏa thuận được hai bên thống nhất.'),
                // SizedBox(height: 8.px),
                // _buildText(
                //     text:
                //         '2. Giá cho thuê trong thời hạn từ ngày ${controller.formDateController.text} đến ${controller.toDateController.text} là @@'),
                // SizedBox(height: 8.px),
                // _buildText(
                //     text:
                //         '3. Các điều khoản trong Hợp đòng thuê nhà số ${controller.contractByIdModel?.id} đã ký ngày ${controller.contractByIdModel?.dateCreated?.ddMMyyyy} và các phụ lục số @@ không thay đổi'),
                // SizedBox(height: 8.px),
                // _buildText(
                //   text: 'ĐIỀU 2: ĐIỀU KHOẢN THI HÀNH',
                //   textStyle: childTextStyle.copyWith(
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
                // SizedBox(height: 8.px),
                // _buildText(
                //     text:
                //         '- Phụ lục hợp đồng này là một bộ phận không tách rời của Hợp đồng thuê nhà số ${controller.contractByIdModel?.id}, đã ký ngày ${controller.contractByIdModel?.dateCreated?.ddMMyyyy}'),
                // SizedBox(height: 8.px),
                // _buildText(
                //     text:
                //         '- Phụ lục hợp đồng này có hiệu lực từ ngày ${controller.formDateController.text}.'),
                // SizedBox(height: 8.px),
                // _buildText(
                //     text:
                //         '- Phụ lục hợp đồng này được thành lập @@ bản, mỗi bên giữ 1 bản và có giá trị pháp lý như nhau'),

                SizedBox(height: 16.px),
                Container(
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1.px,
                              color: AppColors.secondary20,
                            ),
                          ),
                          child: Column(
                            children: [
                              _buildText(
                                text: 'Đại diện bên A',
                                textStyle: childTextStyle.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                                alignment: Alignment.center,
                              ),
                              SizedBox(height: 4.px),
                              _buildText(
                                text: '(Ký ghi rõ họ tên)',
                                alignment: Alignment.center,
                              ),
                              SizedBox(
                                height: 80.px,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1.px,
                              color: AppColors.secondary20,
                            ),
                          ),
                          child: Column(
                            children: [
                              _buildText(
                                text: 'Đại diện bên B',
                                textStyle: childTextStyle.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                                alignment: Alignment.center,
                              ),
                              SizedBox(height: 4.px),
                              _buildText(
                                text: '(Ký ghi rõ họ tên)',
                                alignment: Alignment.center,
                              ),
                              SizedBox(
                                height: 80.px,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildText({
    required String text,
    AlignmentGeometry? alignment,
    TextStyle? textStyle,
  }) {
    return Align(
      alignment: alignment ?? Alignment.centerLeft,
      child: Text.rich(
        style: textStyle ?? childTextStyle,
        TextSpan(text: text),
      ),
    );
  }

  Center _builtTitleContract() {
    return Center(
      child: Text.rich(
        TextSpan(
            text: 'Phụ lục hợp đồng thuê trọ'.tr.toUpperCase(),
            style: childTextStyle.copyWith(fontWeight: FontWeight.bold)),
      ),
    );
  }

  Center _buildMotto() {
    return Center(
      child: Text.rich(
        TextSpan(text: 'motto'.tr.toUpperCase(), style: childTextStyle),
      ),
    );
  }

  Center _buildNationalTitle() {
    return Center(
      child: Text.rich(
        textAlign: TextAlign.center,
        TextSpan(
          text: 'national_title'.tr.toUpperCase(),
          style: TextStyle(
            fontSize: 16.sp,
            color: AppColors.secondary40,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Align _buildHeader() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        'preview_contract_template'.tr,
        style: TextStyle(
          color: AppColors.primary40,
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
