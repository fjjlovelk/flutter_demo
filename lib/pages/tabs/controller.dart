import 'package:get/get.dart';

import 'state.dart';

class TabsController extends GetxController {
  final TabsState state = TabsState();

  @override
  void onClose() {
    // 销毁时需要dispose pageController
    state.pageController.dispose();
    super.onClose();
  }

  /// bottomNavigationBar点击事件
  void bottomNavigationBarTab(int index) {
    // 切换page时会触发onPageChanged事件，因此此时无需设置currentTab
    state.pageController.jumpToPage(index);
  }

  /// page change
  void onPageChanged(int index) {
    state.currentTab = index;
  }
}
