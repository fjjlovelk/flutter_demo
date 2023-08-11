import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';

/// FileUpload中的加号
class ImageSelect extends StatelessWidget {
  final num size;

  final int countLimit;

  final ImagePicker imagePicker = ImagePicker();

  ImageSelect({Key? key, this.size = 80, this.countLimit = 5})
      : super(key: key);

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
    List<XFile>? pickedFile = await imagePicker.pickMultiImage();
    print(pickedFile);
  }

  /// 选择拍照
  void onSelectCamera() async {
    Get.back();
    XFile? pickedFile = await imagePicker.pickImage(source: ImageSource.camera);
    if (pickedFile == null) {
      return;
    }
    Uint8List bytes = await pickedFile.readAsBytes();
    final result = await ImageGallerySaver.saveImage(bytes, quality: 100);
    print(pickedFile);
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
        width: ScreenUtil().setWidth(size),
        height: ScreenUtil().setWidth(size),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black.withOpacity(0.3)),
        ),
        child: Icon(
          Icons.add,
          size: ScreenUtil().setWidth((size / 3).truncate()),
          color: Colors.black.withOpacity(0.3),
        ),
      ),
    );
  }
}
