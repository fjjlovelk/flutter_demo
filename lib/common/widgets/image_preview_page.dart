import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ImagePreviewPage extends StatefulWidget {
  /// 图片列表
  final List<String> imageItems;

  /// 当前图片
  final int currentIndex;

  /// 控制器
  final PageController? pageController;

  /// 默认缩放
  final double initialScale;

  /// 最大缩放
  final double maxScale;

  /// 最小缩放
  final double minScale;

  /// 是否显示顶部数字栏
  final bool showAppBar;

  /// 是否显示底部指示器
  final bool showBottomIndicator;

  const ImagePreviewPage({
    Key? key,
    required this.imageItems,
    this.currentIndex = 0,
    this.pageController,
    this.initialScale = 1.0,
    this.maxScale = 2.0,
    this.minScale = 1.0,
    this.showAppBar = true,
    this.showBottomIndicator = true,
  }) : super(key: key);

  @override
  State<ImagePreviewPage> createState() => _ImagePreviewPageState();
}

class _ImagePreviewPageState extends State<ImagePreviewPage> {
  final ValueNotifier<int> _currentIndex = ValueNotifier(0);
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = widget.pageController ??
        PageController(initialPage: widget.currentIndex);
    _currentIndex.value = widget.currentIndex;
  }

  @override
  void dispose() {
    _pageController.dispose();
    _currentIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        title: widget.showAppBar
            ? ValueListenableBuilder(
                valueListenable: _currentIndex,
                builder: (context, value, child) => Text(
                  '${value + 1}/${widget.imageItems.length}',
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
              )
            : null,
      ),
      backgroundColor: Colors.black,
      floatingActionButton: widget.showBottomIndicator
          ? ValueListenableBuilder(
              valueListenable: _currentIndex,
              builder: (context, value, child) => _BottomIndicator(
                length: widget.imageItems.length,
                currentIndex: value,
              ),
            )
          : null,
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      body: GestureDetector(
        onTap: () => Get.back(),
        onVerticalDragEnd: (_) => Get.back(),
        child: PhotoViewGallery.builder(
          wantKeepAlive: true,
          builder: (BuildContext context, int index) {
            return PhotoViewGalleryPageOptions(
              // heroAttributes: PhotoViewHeroAttributes(
              //   tag: widget.imageItems[index],
              // ),
              imageProvider: CachedNetworkImageProvider(
                widget.imageItems[index],
              ),
              initialScale:
                  PhotoViewComputedScale.contained * widget.initialScale,
              maxScale: PhotoViewComputedScale.contained * widget.maxScale,
              minScale: PhotoViewComputedScale.contained * widget.minScale,
            );
          },
          scrollPhysics: const ClampingScrollPhysics(),
          loadingBuilder: (context, event) => const Center(
            child: CupertinoActivityIndicator(
              color: Colors.white,
              radius: 20,
            ),
          ),
          itemCount: widget.imageItems.length,
          pageController: _pageController,
          backgroundDecoration: const BoxDecoration(color: Colors.black),
          onPageChanged: (v) => _currentIndex.value = v,
        ),
      ),
    );
  }
}

/// 底部的指示器
class _BottomIndicator extends StatelessWidget {
  final int length;
  final int currentIndex;
  const _BottomIndicator({
    Key? key,
    required this.length,
    required this.currentIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        length,
        (index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: CircleAvatar(
            radius: 4,
            backgroundColor: currentIndex == index ? Colors.white : Colors.grey,
          ),
        ),
      ),
    );
  }
}
