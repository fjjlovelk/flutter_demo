import 'package:flutter/material.dart';
import 'package:flutter_demo/common/models/file_model.dart';
import 'package:flutter_demo/common/widgets/remote_image.dart';
import 'package:get/get.dart';

import 'image_preview_page.dart';

class ImagePreview extends StatelessWidget {
  /// 图片列表
  final List<FileModel> imageItems;

  /// 每行个数
  final int rowCount;

  /// 间隔
  final double spacing;

  const ImagePreview({
    Key? key,
    required this.imageItems,
    this.rowCount = 4,
    this.spacing = 8,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: imageItems.length,
      padding: EdgeInsets.all(spacing),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: rowCount,
        mainAxisSpacing: spacing,
        crossAxisSpacing: spacing,
      ),
      itemBuilder: (_, index) {
        return InkWell(
          onTap: () {
            Get.to(
              () => ImagePreviewPage(
                imageItems: imageItems.map((e) => e.filepath).toList(),
                currentIndex: index,
              ),
              transition: Transition.zoom,
            );
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: RemoteImage(url: imageItems[index].filepath),
          ),
        );
      },
    );
  }
}
