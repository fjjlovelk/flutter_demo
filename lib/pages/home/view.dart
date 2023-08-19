import 'package:flutter/material.dart';
import 'package:flutter_demo/common/widgets/image_preview.dart';
import 'package:flutter_demo/common/widgets/image_upload.dart';
import 'package:flutter_demo/pages/home/controller.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("HomePage----build");
    return Scaffold(
      appBar: AppBar(
        title: const Text('首页'),
      ),
      body: Column(
        children: [
          GetBuilder<HomeController>(
            id: 'ImageUpload',
            init: HomeController(),
            builder: (_) => ImageUpload(
              items: controller.state.fileList,
              onChange: controller.onChange,
            ),
          ),
          GetBuilder<HomeController>(
            id: 'ImagePreview',
            init: HomeController(),
            builder: (_) => ImagePreview(
              items: controller.state.fileList,
            ),
          ),
        ],
      ),
    );
  }
}
