import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MapScreenController extends GetxController {
  Location? crLocation;
  final currenLocation = ''.obs;
  final webViewController = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..loadRequest(Uri.parse('https://www.google.com/maps'));

  Future<void> getCurrentLocation() async {}
}
