import 'package:get/get.dart';

import 'controller.dart';

class PullRefreshBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PullRefreshController());
  }
}
