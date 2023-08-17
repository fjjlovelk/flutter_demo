import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/common/api/user_api.dart';
import 'package:flutter_demo/common/enums/upload_state_enum.dart';
import 'package:flutter_demo/common/widgets/remote_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImageUploadItem extends StatefulWidget {
  /// 盒子大小，默认80
  final double boxSize;

  /// 文件本地路径
  final String path;

  /// 文件网络路径
  final String url;

  /// 上传成功回调
  final void Function(Map<String, String>) onSuccess;

  /// 上传失败回调
  final void Function()? onError;

  /// 长按回调
  final void Function()? onLongPress;

  const ImageUploadItem({
    Key? key,
    required this.path,
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
    if (widget.url.isNotEmpty) {
      _isSuccess.value = UploadStateEnum.success;
      return;
    }
    UserApi.upload(
      {"singleFile": await MultipartFile.fromFile(widget.path)},
      onSendProgress: (int count, int total) {
        _progress.value = (count * 100 / total);
      },
    ).then((value) {
      _isSuccess.value = UploadStateEnum.success;
      widget.onSuccess.call({
        "filepath": value.filepath,
        "filename": value.filename,
      });
    }).catchError((err) {
      _isSuccess.value = UploadStateEnum.fail;
      widget.onError?.call();
    });
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
            // const _ImageBackground(),
            _ImageChild(path: widget.path, url: widget.url),
            AnimatedBuilder(
              animation: Listenable.merge([
                _progress,
                _isSuccess,
              ]),
              builder: (context, child) {
                switch (_isSuccess.value) {
                  case UploadStateEnum.uploading:
                    return _UploadBackground(progress: _progress.value);
                  case UploadStateEnum.success:
                    return const SizedBox();
                  case UploadStateEnum.fail:
                    return const _FailedBackground();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

/// image
class _ImageChild extends StatelessWidget {
  /// 文件本地路径
  final String path;

  /// 文件网络路径
  final String url;

  const _ImageChild({
    Key? key,
    required this.path,
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
        child: path.isNotEmpty
            ? Image.file(
                File(path),
                gaplessPlayback: true,
                fit: BoxFit.cover,
              )
            : RemoteImage(url: url),
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
        child: Column(
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
        ),
      ),
    );
  }
}

/// 上传失败的背景
class _FailedBackground extends StatelessWidget {
  const _FailedBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        child: const Text(
          "上传失败",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
