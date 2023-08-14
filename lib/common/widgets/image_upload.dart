import 'package:flutter/material.dart';
import 'package:flutter_demo/common/models/file_model.dart';
import 'package:flutter_demo/common/utils/loading.dart';
import 'package:flutter_demo/common/widgets/image_select.dart';
import 'package:flutter_demo/common/widgets/image_upload_item.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImageUpload extends StatelessWidget {
  /// 文件列表
  final List<FileModel> _fileList = <FileModel>[].obs;

  /// 数量限制
  final int countLimit;

  /// 大小限制，单位：MB
  final int sizeLimit;

  ImageUpload({
    Key? key,
    this.countLimit = 5,
    this.sizeLimit = 2,
  }) : super(key: key);

  /// 选择照片/拍照 触发事件
  void onChange(List<XFile> file) {
    if (_fileList.length + file.length > countLimit) {
      Loading.showInfo('最多只能选择$countLimit张图片');
      return;
    }
    for (var item in file) {
      final fileModel = FileModel(data: item);
      _fileList.add(fileModel);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Wrap(
        children: [
          ..._fileList.map((e) => ImageUploadItem(path: e.data!.path)).toList(),
          if (countLimit != -1 && _fileList.length < countLimit)
            ImageSelect(
              countLimit: countLimit,
              onChange: onChange,
            ),
        ],
      ),
    );
  }
}
