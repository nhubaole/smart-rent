import 'package:get/get.dart';

class HomePopularController extends GetxController {
  RxList<Map<String, dynamic>> dataList = <Map<String, dynamic>>[].obs;
  var isLoading = true.obs;

  void fetchDataAndConvertToList() {
    List<Map<String, dynamic>> fetchedData = [
      {
        'address': 'Quận 1',
        'photoUrl':
            'https://images.unsplash.com/photo-1696986293936-d8d080a88f50?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2671&q=80',
      },
      {
        'address': 'Quận 2',
        'photoUrl':
            'https://images.unsplash.com/photo-1695653422676-d9dd88400e21?ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2574&q=80',
      },
      {
        'address': 'Quận 3',
        'photoUrl':
            'https://images.unsplash.com/photo-1697044504071-12d33cc757cc?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2574&q=80',
      },
      {
        'address': 'Quận 1',
        'photoUrl':
            'https://images.unsplash.com/photo-1696986293936-d8d080a88f50?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2671&q=80',
      },
      {
        'address': 'Quận 2',
        'photoUrl':
            'https://images.unsplash.com/photo-1695653422676-d9dd88400e21?ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2574&q=80',
      },
      {
        'address': 'Quận 3',
        'photoUrl':
            'https://images.unsplash.com/photo-1697044504071-12d33cc757cc?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2574&q=80',
      },
      {
        'address': 'Quận 1',
        'photoUrl':
            'https://images.unsplash.com/photo-1696986293936-d8d080a88f50?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2671&q=80',
      },
      {
        'address': 'Quận 2',
        'photoUrl':
            'https://images.unsplash.com/photo-1695653422676-d9dd88400e21?ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2574&q=80',
      },
      {
        'address': 'Quận 3',
        'photoUrl':
            'https://images.unsplash.com/photo-1697044504071-12d33cc757cc?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2574&q=80',
      },
      {
        'address': 'Quận 1',
        'photoUrl':
            'https://images.unsplash.com/photo-1696986293936-d8d080a88f50?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2671&q=80',
      },
      {
        'address': 'Quận 2',
        'photoUrl':
            'https://images.unsplash.com/photo-1695653422676-d9dd88400e21?ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2574&q=80',
      },
      {
        'address': 'Quận 3',
        'photoUrl':
            'https://images.unsplash.com/photo-1697044504071-12d33cc757cc?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2574&q=80',
      },
    ];

    dataList.assignAll(fetchedData);
    isLoading.value = false;
  }
}
