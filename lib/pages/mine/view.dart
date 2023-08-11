import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

class MinePage extends GetView<MineController> {
  const MinePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('我的'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: controller.logout,
          child: const Text('退出登录'),
        ),
      ),
    );
  }
}
