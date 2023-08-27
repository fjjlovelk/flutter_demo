import 'package:flutter/material.dart';
import 'package:flutter_demo/common/router/app_routes.dart';
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
          ImageUpload(
            controller: controller.state.imageUploadController,
          ),
          // GetBuilder<HomeController>(
          //   id: 'ImagePreview',
          //   init: HomeController(),
          //   builder: (_) => ImagePreview(
          //     items: controller.state.fileList,
          //   ),
          // ),
          ElevatedButton(
            onPressed: () {
              Get.toNamed(AppRoutes.pullRefresh);
              // print(controller.state.imageUploadController.toString());
            },
            child: const Text('pull_refresh demo page'),
          ),
        ],
      ),
    );
  }
}
