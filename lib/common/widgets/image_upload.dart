import 'package:flutter/material.dart';
import 'package:flutter_demo/common/widgets/image_select.dart';

class ImageUpload extends StatefulWidget {
  /// 文件列表
  // final List<String> fileList;

  /// 数量限制
  final int countLimit;

  /// 大小限制，单位：MB
  final int sizeLimit;

  const ImageUpload({
    Key? key,
    // this.fileList,
    this.countLimit = 5,
    this.sizeLimit = 2,
  }) : super(key: key);

  @override
  State<ImageUpload> createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {
  @override
  Widget build(BuildContext context) {
    return ImageSelect();
  }
}
