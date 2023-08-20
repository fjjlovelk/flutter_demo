import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/common/utils/loading_util.dart';
import 'package:flutter_demo/common/utils/permission_util.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

/// FileUpload中的加号
class ImageSelect extends StatelessWidget {
  final ImagePicker _picker = ImagePicker();

  /// 盒子大小，默认80
  final double boxSize;

  /// 选择图片数量，-1为无限制，默认5张
  final int countLimit;

  /// 已选选择图片数量
  final int selectedCount;

  final void Function(List<AssetEntity>) onChange;

  ImageSelect({
    Key? key,
    this.boxSize = 80,
    this.countLimit = -1,
    required this.onChange,
    this.selectedCount = 0,
  }) : super(key: key);

  /// 点击事件
  void onTab(BuildContext context) async {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            onPressed: () => onSelectPhoto(),
            child: countLimit == -1
                ? const Text('图片')
                : Text('图片 (最多$countLimit张)'),
          ),
          CupertinoActionSheetAction(
            onPressed: () => onSelectCamera(),
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
  void onSelectPhoto() async {
    Get.back();
    // 请求相册权限
    bool isPhotosGranted = await PermissionUtil.photos();
    if (!isPhotosGranted) {
      return;
    }
    // 媒体位置权限
    bool isAccessMediaLocationGranted =
        await PermissionUtil.accessMediaLocation();
    if (!isAccessMediaLocationGranted) {
      return;
    }
    final List<AssetEntity>? result = await AssetPicker.pickAssets(
      Get.context!,
      pickerConfig: AssetPickerConfig(
        maxAssets: (countLimit == -1 ? 99 : countLimit) - selectedCount,
        requestType: RequestType.image,
        textDelegate: const AssetPickerTextDelegate(),
      ),
    );
    if (result == null) {
      return;
    }
    onChange(result);
  }

  /// 选择拍照
  void onSelectCamera() async {
    Get.back();
    // 请求摄像头权限
    bool isCameraGranted = await PermissionUtil.camera();
    if (!isCameraGranted) {
      return;
    }
    // 请求存储权限
    bool isStorageGranted = await PermissionUtil.storage();
    if (!isStorageGranted) {
      return;
    }
    // 调用拍照
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo == null) {
      return;
    }
    final bytes = await photo.readAsBytes();
    // 将photo保存到设备，并获得AssetEntity
    final AssetEntity? result = await PhotoManager.editor.saveImage(
      bytes,
      title: photo.name, // 可能影响 EXIF 信息的读取
    );
    if (result == null) {
      LoadingUtil.showError("图片保存失败");
      return;
    }
    // 将拍照生成的图片路径保存
    List<AssetEntity> pickedFile = [result];
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
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: boxSize,
        height: boxSize,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          Icons.add,
          size: (boxSize / 3).truncateToDouble(),
          color: Colors.black.withOpacity(0.3),
        ),
      ),
    );
  }
}
