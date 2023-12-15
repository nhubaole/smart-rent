import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_rent/modules/onboarding/views/onboarding_screen.dart';

class OnBoardingController extends GetxController {
  late PageController pagesController;
  RxInt currentPage = 0.obs;
  RxBool isFinalPage = false.obs;
  List<OnBoardingContent> listOnBoarding = [
    const OnBoardingContent(
      image: 'assets/images/ic_onboarding1.png',
      title: 'Chào mừng bạn đến với ứng dụng',
      subTitle: 'Smart Rent House',
      description:
          'Nền tảng tuyệt vời để bạn tìm kiếm và thuê phòng trọ dễ dàng và nhanh chóng ',
    ),
    const OnBoardingContent(
      image: 'assets/images/ic_onboarding2.png',
      title: 'Khám phá các lựa chọn phòng trọ đa dạng',
      description:
          ' Với công cụ tìm kiếm tiện lợi, bạn có thể dễ dàng tìm kiếm phòng trọ theo như mong muốn và khám phá các lựa chọn phòng trọ tuyệt vời.',
    ),
    const OnBoardingContent(
      image: 'assets/images/ic_onboarding3.png',
      title: 'Thuận tiện đăng bài cho thuê phòng trọ',
      description:
          'Dễ dàng đăng bài cho thuê chỉ trong vài bước đơn giản. Cung cấp thông tin chi tiết về phòng, hình ảnh hấp dẫn và tiện ích để thu hút người thuê tiềm năng.',
    ),
  ];
}
