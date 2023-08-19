import 'package:flutter/material.dart';
import 'package:flutter_demo/common/widgets/remote_image.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class ImagePreviewItem extends StatelessWidget {
  /// 文件本地路径
  final AssetEntity? assetEntity;

  /// 文件网络路径
  final String url;

  const ImagePreviewItem({
    Key? key,
    this.assetEntity,
    required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        // 优先展示本地图片
        child: assetEntity != null
            ? AssetEntityImage(
                assetEntity!,
                isOriginal: false,
                fit: BoxFit.cover,
              )
            : RemoteImage(url: url),
      ),
    );
  }
}
