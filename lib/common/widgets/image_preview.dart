import 'package:flutter/material.dart';
import 'package:flutter_demo/common/models/file_model.dart';
import 'package:flutter_demo/common/utils/file_util.dart';
import 'package:flutter_demo/common/widgets/image_preview_item.dart';

class ImagePreview extends StatelessWidget {
  /// 图片列表
  final List<FileModel> items;

  /// 每行个数
  final int rowCount;

  /// 间隔
  final double spacing;

  const ImagePreview({
    Key? key,
    required this.items,
    this.rowCount = 4,
    this.spacing = 8,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final imageItems = items.where((e) => e.filepath.isNotEmpty).toList();
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
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
            FileUtil.previewImage(
              context,
              imageItems: imageItems.map((e) => e.filepath).toList(),
              currentIndex: index,
            );
          },
          child: ImagePreviewItem(
            url: imageItems[index].filepath,
          ),
        );
      },
    );
  }
}
