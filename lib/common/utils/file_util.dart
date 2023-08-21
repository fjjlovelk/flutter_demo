import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_demo/common/widgets/image_preview_page.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class FileUtil {
  /// 通过AssetEntity获取本地文件
  static Future<File> getFileByAssetEntity(AssetEntity assetEntity) async {
    try {
      final file = await assetEntity.file;
      if (file == null) {
        throw StateError(
            'Unable to obtain bytes of the entity ${assetEntity.id}.');
      }
      return file;
    } catch (err) {
      rethrow;
    }
  }

  /// 图片压缩 -- [bytes] 文件字节；[targetSize] 目标大小，默认1，单位：Mb
  static Future<Uint8List> compressImage(
    Uint8List bytes, {
    int targetSize = 1,
    ValueNotifier<bool>? cancelCompress,
  }) async {
    try {
      double size = bytes.length / 1024 / 1024;
      debugPrint("压缩前图片的大小：$size");
      Uint8List result = bytes;
      int count = 0;
      int quality = 90;
      while (size > targetSize) {
        if (cancelCompress != null && cancelCompress.value) {
          break;
        }
        result = await FlutterImageCompress.compressWithList(result,
            quality: quality);
        size = result.length / 1024 / 1024;
        count++;
        quality -= 15;
        debugPrint("图片压缩count---------$count");
      }
      debugPrint("压缩后图片的大小：$size---------压缩了$count次");
      return result;
    } catch (err) {
      throw StateError('图片压缩失败');
    }
  }

  /// 预览图片大图
  static void previewImage(
    BuildContext context, {
    required List<String> imageItems,
    int currentIndex = 0,
  }) {
    Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 50),
        pageBuilder: (_, __, ___) => ImagePreviewPage(
          imageItems: imageItems,
          currentIndex: currentIndex,
        ),
        transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }
}
