import 'package:get/get.dart';

class HomePopularController extends GetxController {
  RxList<Map<String, dynamic>> dataList = <Map<String, dynamic>>[].obs;
  var isLoading = true.obs;

  void fetchDataAndConvertToList() {
    List<Map<String, dynamic>> fetchedData = [
      {
        'address': 'Thủ Đức',
        'photoUrl':
            'https://upload.wikimedia.org/wikipedia/commons/1/15/Ch%E1%BB%A3_Th%E1%BB%A7_%C4%90%E1%BB%A9c.jpg',
      },
      {
        'address': 'Quận 3',
        'photoUrl':
            'https://travelsgcc.com/wp-content/uploads/2020/03/ho-con-rua.jpg',
      },
      {
        'address': 'Bình Thạnh',
        'photoUrl':
            'https://go2joy.s3.ap-southeast-1.amazonaws.com/blog/wp-content/uploads/2023/01/04154942/landmark-81-binh-thanh.jpg',
      },
      {
        'address': 'Quận 1',
        'photoUrl':
            'https://images2.thanhnien.vn/528068263637045248/2023/3/16/base64-16789444054471877099818.png',
      },
      {
        'address': 'Quận 7',
        'photoUrl':
            'https://dulichkhampha24.com/wp-content/uploads/2020/01/cau-anh-sao-sai-gon-3.jpg',
      }
    ];

    dataList.assignAll(fetchedData);
    isLoading.value = false;
  }
}
