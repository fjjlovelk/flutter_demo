import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';

/// FileUpload中的加号
class ImageSelect extends StatelessWidget {
  /// 盒子大小，默认80
  final double boxSize;

  /// 选择图片数量，-1为无限制，默认5张
  final int countLimit;

  final void Function(List<XFile>) onChange;

  final ImagePicker imagePicker = ImagePicker();

  ImageSelect({
    Key? key,
    this.boxSize = 80,
    this.countLimit = -1,
    required this.onChange,
  }) : super(key: key);

  /// 点击事件
  void onTab() async {
    showCupertinoModalPopup(
      context: Get.context!,
      builder: (_) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            onPressed: onSelectPhoto,
            child: countLimit == -1
                ? const Text('图片')
                : Text('图片 (最多$countLimit张)'),
          ),
          CupertinoActionSheetAction(
            onPressed: onSelectCamera,
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
    List<XFile> pickedFile = await imagePicker.pickMultiImage();
    if (pickedFile.isEmpty) {
      return;
    }
    onChange(pickedFile);
  }

  /// 选择拍照
  void onSelectCamera() async {
    Get.back();
    // 调用拍照
    XFile? pickedFile = await imagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 100,
    );
    if (pickedFile == null) {
      return;
    }
    // 将拍照的临时图片保存到手机
    await ImageGallerySaver.saveFile(pickedFile.path);
    List<XFile> list = [];
    list.add(pickedFile);
    onChange(list);
  }

  /// 取消
  void onSelectCancel() {
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTab,
      splashColor: Colors.black.withOpacity(0.1),
      child: Container(
        width: ScreenUtil().setWidth(boxSize),
        height: ScreenUtil().setWidth(boxSize),
        alignment: Alignment.center,
        decoration: BoxDecoration(
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
