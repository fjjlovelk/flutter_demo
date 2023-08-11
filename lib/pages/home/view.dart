import 'package:flutter/material.dart';
import 'package:flutter_demo/common/widgets/image_upload.dart';
import 'package:flutter_demo/pages/home/controller.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('首页'),
      ),
      body: const ImageUpload(),
    );
  }
}
