import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/common/api/user_api.dart';
import 'package:flutter_demo/common/enums/upload_state_enum.dart';
import 'package:flutter_demo/common/models/file_model.dart';
import 'package:flutter_demo/common/utils/file_util.dart';
import 'package:flutter_demo/common/utils/loading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

import 'image_preview_item.dart';

class ImageUploadItem extends StatefulWidget {
  /// 盒子大小，默认80
  final double boxSize;

  /// 文件本地路径
  final AssetEntity? assetEntity;

  /// 文件网络路径
  final String url;

  /// 上传成功回调
  final void Function(FileModel) onSuccess;

  /// 上传失败回调
  final void Function()? onError;

  /// 长按回调
  final void Function()? onLongPress;

  const ImageUploadItem({
    Key? key,
    this.assetEntity,
    required this.url,
    this.boxSize = 80,
    required this.onSuccess,
    this.onError,
    this.onLongPress,
  }) : super(key: key);

  @override
  State<ImageUploadItem> createState() => _ImageUploadItemState();
}

class _ImageUploadItemState extends State<ImageUploadItem> {
  /// 是否上传成功
  final _isSuccess = ValueNotifier(UploadStateEnum.uploading);

  /// 上传进度
  final _progress = ValueNotifier(0.0);

  @override
  void initState() {
    super.initState();
    onUpload();
  }

  /// 上传
  onUpload() async {
    // 编辑状态下，回显的数据不需要再次上传
    if (widget.url.isNotEmpty || widget.assetEntity == null) {
      _isSuccess.value = UploadStateEnum.success;
      return;
    }
    try {
      final bytes = await widget.assetEntity!.originBytes;
      if (bytes == null) {
        Loading.showError(
            'Unable to obtain file of the entity ${widget.assetEntity!.id}.');
        return;
      }
      final compressedBytes = await FileUtil.compressImage(bytes);
      final result = await UserApi.upload(
        {
          "singleFile": MultipartFile.fromBytes(
            compressedBytes,
            filename: widget.assetEntity!.title,
          )
        },
        onSendProgress: (int count, int total) {
          _progress.value = (count * 100 / total);
        },
      );
      _isSuccess.value = UploadStateEnum.success;
      widget.onSuccess.call(result);
    } catch (err) {
      _isSuccess.value = UploadStateEnum.fail;
      widget.onError?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: widget.onLongPress,
      child: SizedBox(
        width: widget.boxSize,
        height: widget.boxSize,
        child: Stack(
          fit: StackFit.expand,
          children: [
            ImagePreviewItem(assetEntity: widget.assetEntity, url: widget.url),
            AnimatedBuilder(
              animation: Listenable.merge([
                _progress,
                _isSuccess,
              ]),
              builder: (context, child) {
                if (_isSuccess.value == UploadStateEnum.success) {
                  return const SizedBox();
                }
                return Positioned(
                  top: 0,
                  right: 0,
                  bottom: 0,
                  left: 0,
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.black45,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: _isSuccess.value == UploadStateEnum.uploading
                        ? _UploadBackground(progress: _progress.value)
                        : const _FailedBackground(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

/// 上传中的背景
class _UploadBackground extends StatelessWidget {
  final double progress;

  const _UploadBackground({Key? key, required this.progress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "${progress.toStringAsFixed(2)}%",
          style: const TextStyle(color: Colors.white),
        ),
        Text(
          "上传中",
          style: TextStyle(color: Colors.white, fontSize: 14.sp),
        ),
      ],
    );
  }
}

/// 上传失败的背景
class _FailedBackground extends StatelessWidget {
  const _FailedBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      "上传失败",
      style: TextStyle(color: Colors.white),
    );
  }
}
