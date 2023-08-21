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
          filename: 'pexels-andras-stefuca-18003658.jpg',
          filepath:
              "http://172.20.10.6:4396/uploads/1692583554882-pexels-andras-stefuca-18003658.jpg",
        ),
        FileModel(
          filename: "pexels-kelly-17333445.jpg",
          filepath:
              "http://172.20.10.6:4396/uploads/1692583767650-pexels-kelly-17333445.jpg",
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
