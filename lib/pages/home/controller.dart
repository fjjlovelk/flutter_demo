import 'package:get/get.dart';

import 'state.dart';

class HomeController extends GetxController {
  final HomeState state = HomeState();

  /// bottomNavigationBar点击事件
  void bottomNavigationBarTab(int index) {
    state.currentTab = index;
  }
}
