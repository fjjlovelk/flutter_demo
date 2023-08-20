import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/common/models/file_model.dart';
import 'package:flutter_demo/common/utils/loading_util.dart';
import 'package:flutter_demo/common/widgets/image_select.dart';
import 'package:flutter_demo/common/widgets/image_upload_item.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class ImageUpload extends StatelessWidget {
  /// 文件列表
  final List<FileModel> items;

  /// 文件改变的回调
  final void Function(List<FileModel>) onChange;

  /// 每行个数
  final int rowCount;

  /// 间隔
  final double spacing;

  /// 数量限制
  final int countLimit;

  /// 大小限制，单位：MB
  final int sizeLimit;

  const ImageUpload({
    Key? key,
    this.rowCount = 4,
    this.spacing = 8,
    this.countLimit = 5,
    this.sizeLimit = 2,
    required this.onChange,
    required this.items,
  }) : super(key: key);

  /// 选择照片/拍照 触发事件
  void imageChange(List<AssetEntity> file) {
    if (items.length + file.length > countLimit) {
      LoadingUtil.showInfo('最多只能选择$countLimit张图片');
      return;
    }
    final List<FileModel> list = [...items];
    for (var item in file) {
      final fileModel = FileModel(assetEntity: item);
      list.add(fileModel);
    }
    onChange.call(list);
  }

  @override
  Widget build(BuildContext context) {
    final fileList = items.map((e) => FileModel.fromJson(e.toJson())).toList();
    final noPlusIcon = countLimit != -1 && fileList.length == countLimit;
    return GridView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.all(spacing),
      itemCount: fileList.length + (noPlusIcon ? 0 : 1),
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: rowCount,
        mainAxisSpacing: spacing,
        crossAxisSpacing: spacing,
      ),
      itemBuilder: (_, index) {
        if (!noPlusIcon && index == fileList.length) {
          return ImageSelect(
            countLimit: countLimit,
            selectedCount: fileList.length,
            onChange: imageChange,
          );
        }
        final e = fileList[index];
        return ImageUploadItem(
          key: ValueKey<String>(
              e.filepath.isNotEmpty ? e.filepath : (e.assetEntity?.id ?? '')),
          assetEntity: e.assetEntity,
          url: e.filepath,
          onSuccess: (f) {
            e.filepath = f.filepath;
            e.filename = f.filename;
            onChange.call(fileList);
          },
          onError: () {
            fileList.remove(e);
            onChange.call(fileList);
          },
          onLongPress: (CancelToken cancelToken) {
            cancelToken.cancel();
            fileList.remove(e);
            onChange.call(fileList);
          },
        );
      },
    );
  }
}
