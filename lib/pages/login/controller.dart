import 'package:flutter_demo/common/store/user.dart';
import 'package:get/get.dart';

import 'state.dart';

class LoginController extends GetxController {
  final LoginState state = LoginState();

  /// 登录
  void login() {
    UserStore.to.handleLogin({"username": '1111', "password": '2222'});
  }
}
