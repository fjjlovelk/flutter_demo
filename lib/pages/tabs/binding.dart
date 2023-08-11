import 'package:flutter_demo/pages/home/controller.dart';
import 'package:flutter_demo/pages/mine/controller.dart';
import 'package:get/get.dart';

import 'controller.dart';

class TabsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TabsController());
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => MineController());
  }
}
