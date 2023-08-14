import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImageUploadItem extends StatelessWidget {
  /// 盒子大小，默认80
  final double boxSize;

  /// 文件本地路径
  final String? path;

  /// 文件网络路径
  final String? url;

  const ImageUploadItem({
    Key? key,
    this.path,
    this.url,
    this.boxSize = 80,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(boxSize),
      height: ScreenUtil().setWidth(boxSize),
      margin: EdgeInsets.only(right: 5.w, bottom: 5.w),
      child: Stack(
        fit: StackFit.expand,
        children: [
          ImageChild(path: path, url: url),
        ],
      ),
    );
  }
}

/// image
class ImageChild extends StatelessWidget {
  /// 文件本地路径
  final String? path;

  /// 文件网络路径
  final String? url;

  const ImageChild({Key? key, this.path, this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      child: path != null
          ? Image.file(
              File(path!),
              fit: BoxFit.cover,
              filterQuality: FilterQuality.none,
            )
          : Image.network(
              url!,
              fit: BoxFit.cover,
            ),
    );
  }
}
