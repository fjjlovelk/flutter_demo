import 'dart:async';

import 'package:flutter_demo/common/models/file_model.dart';
import 'package:get/get.dart';

import 'state.dart';

class HomeController extends GetxController {
  final HomeState state = HomeState();

  @override
  void onInit() {
    getFileList();
    super.onInit();
  }

  void getFileList() async {
    Future.delayed(const Duration(seconds: 2), () {
      final list = [
        FileModel(
          filename: '673994',
          filepath: 'http://192.168.3.25:8000/uploads/1692364263395-673994.png',
        ),
        FileModel(
          filename: '15-53-05-005',
          filepath:
              'http://192.168.3.25:8000/uploads/1692364278346-15-53-05-005.jpg',
        ),
        FileModel(
          filename: '1111',
          filepath: 'http://192.168.3.25:8000/uploads/1692364278589-1111.jpg',
        ),
      ];
      state.fileList.value = list;
      print("getFileList------${state.fileList}");
      update(['ImageUpload', 'ImagePreview']);
    });
  }

  void onChange(List<FileModel> file) {
    print("file---$file");
    state.fileList.value = file;
    update(['ImageUpload', 'ImagePreview']);
  }
}
