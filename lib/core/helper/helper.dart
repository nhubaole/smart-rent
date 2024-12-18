import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:timeago/timeago.dart' as timeago;
import 'package:url_launcher/url_launcher.dart';

class Helper {
  static Future<XFile> compressImage({
    required XFile imageFile,
    int quality = 95,
    CompressFormat format = CompressFormat.jpeg,
  }) async {
    final String targetPath =
        path.join(
        Directory.systemTemp.path, 'temp_${imageFile.name}.${format.name}');
    final XFile? compressedImage =
        await FlutterImageCompress.compressAndGetFile(
            imageFile.path, targetPath,
            quality: quality, format: format);

    if (compressedImage == null) {
      throw ("Failed to compress the image");
    }

    return compressedImage;
  }

  static String uint8ListToBase64(Uint8List data) {
    return base64Encode(data);
  }

  static String getStatus(int status) {
    switch (status) {
      case 0:
        return 'not_processed'.tr;
      case 1:
        return 'pending'.tr;
      case 2:
        return 'accepted'.tr;
      default:
        return '';
    }
  }

  static Future<String?> saveUrlImageToGallery(String url) async {
    try {
      var response = await Dio()
          .get(url, options: Options(responseType: ResponseType.bytes));
      final result = await ImageGallerySaver.saveImage(
          isReturnImagePathOfIOS: true,
          Uint8List.fromList(response.data),
          quality: 60,
          name: "hello");
      log('[saveUrlImageToGallery]: $result');
      if (result['isSuccess']) {
        return result['filePath'];
      } else {
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return 'An error occurred while saving the image.';
    }
  }

  static Future<void> copyToClipBoard({required String content}) async {
    await Clipboard.setData(ClipboardData(text: content));
  }

  static Future<String?> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    return image?.path;
  }

  static Future<void> openGoogleMapsByAddress(String address) async {
    final encodedAddress = Uri.encodeComponent(address);
    print(dotenv.env['google_map_api']!);
    final googleMapsUrl =
        'https://www.google.com/maps/search/?api=${dotenv.env['google_map_api']!}&query=$encodedAddress';
    final googleMapsAppUrl = 'geo:0,0?q=$encodedAddress';

    if (await canLaunchUrl(Uri.parse(googleMapsAppUrl))) {
      await launchUrl(Uri.parse(googleMapsAppUrl));
    } else if (await canLaunchUrl(Uri.parse(googleMapsUrl))) {
      await launchUrl(Uri.parse(googleMapsUrl));
    } else {
      throw 'Could not open Google Maps.';
    }
  }

  static String timeAgo(DateTime date) {
    timeago.setLocaleMessages('vi', timeago.ViMessages());
    return timeago.format(date, locale: 'vi');
  }

}
