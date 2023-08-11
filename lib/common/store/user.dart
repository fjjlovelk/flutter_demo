import 'dart:convert';

import 'package:flutter_demo/common/enums/storage_enum.dart';
import 'package:flutter_demo/common/models/user_info.dart';
import 'package:flutter_demo/common/services/storage_service.dart';
import 'package:get/get.dart';

class UserStore extends GetxController {
  static UserStore get to => Get.find();

  // 是否登录
  final _isLogin = true.obs;

  // 用户信息
  final _userInfo = UserInfoModel().obs;

  // token
  String token = '';

  bool get isLogin => _isLogin.value;

  bool get hasToken => token.isNotEmpty;

  UserInfoModel get userInfo => _userInfo.value;

  @override
  void onInit() {
    super.onInit();
    // 从storage中获取token
    token = StorageService.to.getString(StorageEnum.tokenKey.name);
    // 从storage中获取userInfo
    final userInfoOffline =
        StorageService.to.getString(StorageEnum.userInfo.name);
    if (userInfoOffline.isNotEmpty) {
      _userInfo(UserInfoModel.fromJson(jsonDecode(userInfoOffline)));
    }
    print("userInfoOffline----$userInfoOffline");
    print("token---$token");
  }
}
