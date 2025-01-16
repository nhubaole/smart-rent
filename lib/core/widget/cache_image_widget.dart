import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:smart_rent/core/config/app_colors.dart';
import 'package:smart_rent/core/config/app_constant.dart';

class CacheImageWidget extends StatefulWidget {
  final String imageUrl;
  final BoxFit? fit;
  final double? height;
  final double? width;
  final BorderRadiusGeometry? borderRadius;
  final Color? overlay;
  final bool? shouldExtendCache;
  const CacheImageWidget({
    super.key,
    required this.imageUrl,
    this.fit,
    this.height,
    this.width,
    this.borderRadius,
    this.overlay,
    this.shouldExtendCache = true,
  });

  @override
  State<CacheImageWidget> createState() => _CacheImageWidgetState();
}

class _CacheImageWidgetState extends State<CacheImageWidget>
    with AutomaticKeepAliveClientMixin {

  @override
  void didUpdateWidget(covariant CacheImageWidget oldWidget) {
    if (oldWidget.imageUrl != widget.imageUrl) {
      super.didUpdateWidget(oldWidget);
    }
    super.didUpdateWidget(oldWidget);
  }
      
  @override
  Widget build(BuildContext context) {
    super.build(context);
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

    final cacheImage = widget.shouldExtendCache ?? true
        ? CachedNetworkImage(
            // maxHeightDiskCache: widget.shouldExtendCache == true
            //     ? AppConstant.maxHeightDiskCache
            //     : null,
            // maxWidthDiskCache: widget.shouldExtendCache == true
            //     ? AppConstant.maxWidthDiskCache
            //     : null,
            // memCacheHeight:
            //     widget.shouldExtendCache == true ? AppConstant.memCacheHeight : null,
            // memCacheWidth:
            //     widget.shouldExtendCache == true ? AppConstant.memCacheWidth : null,
            height: widget.height,
            width: widget.width,
            imageUrl: widget.imageUrl,
            alignment: Alignment.center,
            // useOldImageOnUrlChange: true,
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                _buildLoadingProgress(downloadProgress),
            errorWidget: (context, url, error) => _buildErrorImage(),
            fadeInCurve: Curves.bounceInOut,
            fadeInDuration: const Duration(milliseconds: 100),
            fit: widget.fit ?? BoxFit.cover,
            // cacheManager: cacheManager,
          )
        : CachedNetworkImage(
            maxHeightDiskCache: AppConstant.maxHeightDiskCache,
            maxWidthDiskCache: AppConstant.maxWidthDiskCache,
            memCacheHeight: AppConstant.memCacheHeight,
            memCacheWidth: AppConstant.memCacheWidth,
      height: widget.height,
      width: widget.width,
      imageUrl: widget.imageUrl,
      alignment: Alignment.center,
      // useOldImageOnUrlChange: true,
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          _buildLoadingProgress(downloadProgress),
      errorWidget: (context, url, error) => _buildErrorImage(),
      fadeInCurve: Curves.bounceInOut,
      fadeInDuration: const Duration(milliseconds: 100),
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
  
  @override
  bool get wantKeepAlive => true;
}
