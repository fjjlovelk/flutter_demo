import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';

/// FileUpload中的加号
class ImageSelect extends StatelessWidget {
  /// 盒子大小，默认80
  final double boxSize;

  /// 选择图片数量，-1为无限制，默认5张
  final int countLimit;

  final void Function(List<String>) onChange;

  const ImageSelect({
    Key? key,
    this.boxSize = 80,
    this.countLimit = -1,
    required this.onChange,
  }) : super(key: key);

  /// 点击事件
  void onTab(BuildContext context) async {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            onPressed: () => onSelectPhoto(context),
            child: countLimit == -1
                ? const Text('图片')
                : Text('图片 (最多$countLimit张)'),
          ),
          CupertinoActionSheetAction(
            onPressed: () => onSelectCamera(context),
            child: const Text('拍照'),
          )
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: onSelectCancel,
          child: const Text('取消'),
        ),
      ),
    );
  }

  /// 选择图片
  void onSelectPhoto(BuildContext context) async {
    Get.back();
    final List<AssetEntity>? result = await AssetPicker.pickAssets(
      context,
      pickerConfig: AssetPickerConfig(
        maxAssets: countLimit == -1 ? 99 : countLimit,
        requestType: RequestType.image,
      ),
    );
    if (result == null) {
      return;
    }
    // 将选择的图片路径保存
    final List<String> pickedFile = [];
    for (var i in result) {
      final file = await i.file;
      if (file != null) {
        pickedFile.add(file.path);
      }
    }
    onChange(pickedFile);
  }

  /// 选择拍照
  void onSelectCamera(BuildContext context) async {
    Get.back();
    // 调用拍照
    final AssetEntity? result = await CameraPicker.pickFromCamera(context);
    if (result == null) {
      return;
    }
    // 将拍照生成的图片路径保存
    List<String> pickedFile = [];
    final file = await result.file;
    if (file != null) {
      pickedFile.add(file.path);
    }
    onChange(pickedFile);
  }

  /// 取消
  void onSelectCancel() {
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTab(context),
      splashColor: Colors.black.withOpacity(0.1),
      child: Container(
        width: boxSize,
        height: boxSize,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.1),
          border: Border.all(color: Colors.black.withOpacity(0.3)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          Icons.add,
          size: ScreenUtil().setWidth((boxSize / 3).truncate()),
          color: Colors.black.withOpacity(0.3),
        ),
      ),
    );
  }
}
