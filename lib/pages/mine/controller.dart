import 'package:flutter_demo/common/store/user_store.dart';
import 'package:get/get.dart';

import 'state.dart';

class MineController extends GetxController {
  final MineState state = MineState();

  /// 退出登录
  void logout() {
    UserStore.to.handleLogout();
  }
}
