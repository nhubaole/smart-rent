import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:flutter_cache_manager/file.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';

class Helper {
  static Future<XFile> compressImage({
    required XFile imageFile,
    int quality = 95,
    CompressFormat format = CompressFormat.jpeg,
  }) async {
    final String targetPath =
        p.join(Directory.systemTemp.path, 'temp.${format.name}');
    final XFile? compressedImage =
        await FlutterImageCompress.compressAndGetFile(
            imageFile.path, targetPath,
            quality: quality, format: format);

    if (compressedImage == null) {
      throw ("Failed to compress the image");
    }

    return compressedImage;
  }
}
