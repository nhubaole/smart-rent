import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:smart_rent/core/config/app_colors.dart';

class CacheImageWidget extends StatefulWidget {
  final String imageUrl;
  final BoxFit? fit;
  final double? height;
  final double? width;
  final BorderRadiusGeometry? borderRadius;
  final Color? overlay;
  const CacheImageWidget({
    super.key,
    required this.imageUrl,
    this.fit,
    this.height,
    this.width,
    this.borderRadius,
    this.overlay,
  });

  @override
  State<CacheImageWidget> createState() => _CacheImageWidgetState();
}

class _CacheImageWidgetState extends State<CacheImageWidget> {
  @override
  Widget build(BuildContext context) {
    const key = "customKeyCache";

    final customCacheManager = CacheManager(
      Config(
        key,
        stalePeriod: const Duration(minutes: 10),
        maxNrOfCacheObjects: 20,
        repo: JsonCacheInfoRepository(databaseName: key),
        fileService: HttpFileService(),
      ),
    );
    if (widget.overlay != null) {
      return Stack(
        fit: StackFit.expand,
        children: [
          _buildCacheImage(customCacheManager),
          Container(
            height: widget.height,
            width: widget.width,
            decoration: BoxDecoration(
              color: widget.overlay,
              borderRadius: widget.borderRadius,
            ),
          ),
        ],
      );
    }
    return _buildCacheImage(customCacheManager);
  }

  Widget _buildCacheImage(BaseCacheManager? cacheManager) {
    final cacheImage = CachedNetworkImage(
      height: widget.height,
      width: widget.width,
      imageUrl: widget.imageUrl,
      alignment: Alignment.center,
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          _buildLoadingProgress(downloadProgress),
      errorWidget: (context, url, error) => _buildErrorImage(),
      fadeInCurve: Curves.bounceInOut,
      fadeInDuration: const Duration(milliseconds: 200),
      fit: widget.fit ?? BoxFit.cover,
      // cacheManager: cacheManager,
    );

    if (widget.borderRadius != null) {
      return ClipRRect(
        borderRadius: widget.borderRadius!,
        child: cacheImage,
      );
    }

    return cacheImage;
  }

  Center _buildLoadingProgress(DownloadProgress downloadProgress) {
    return Center(
      child: CircularProgressIndicator(
        value: downloadProgress.progress,
        color: AppColors.loading,
        strokeWidth: 2,
      ),
    );
  }

  Column _buildErrorImage() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.error,
          color: AppColors.grey40,
        ),
        Text(
          'Lỗi hình ảnh',
          style: TextStyle(
            color: AppColors.grey40,
          ),
        ),
      ],
    );
  }
}
