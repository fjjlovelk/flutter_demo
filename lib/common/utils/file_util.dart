import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
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
  static Future<Uint8List> compressImage(Uint8List bytes,
      [double targetSize = 1]) async {
    try {
      double size = bytes.length / 1024 / 1024;
      debugPrint("压缩前图片的大小：$size");
      Uint8List result = bytes;
      int count = 0;
      while (size > targetSize) {
        result =
            await FlutterImageCompress.compressWithList(result, quality: 90);
        size = result.length / 1024 / 1024;
        count++;
      }
      debugPrint("压缩了多少次：$count");
      debugPrint("压缩后图片的大小：$size");
      return result;
    } catch (err) {
      throw StateError('图片压缩失败');
    }
  }
}
