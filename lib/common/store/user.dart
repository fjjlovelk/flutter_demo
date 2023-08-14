import 'dart:convert';

import 'package:flutter_demo/common/enums/storage_enum.dart';
import 'package:flutter_demo/common/models/user_model.dart';
import 'package:flutter_demo/common/router/app_routes.dart';
import 'package:flutter_demo/common/services/storage_service.dart';
import 'package:flutter_demo/common/utils/loading.dart';
import 'package:get/get.dart';

class UserStore extends GetxController {
  static UserStore get to => Get.find();

  // 是否登录
  final _isLogin = false.obs;

  // 用户信息
  final _userInfo = UserModel().obs;

  // token
  final RxString _token = ''.obs;

  bool get isLogin => _isLogin.value;

  bool get hasToken => _token.value.isNotEmpty;

  String get token => _token.value;

  UserModel get userInfo => _userInfo.value;

  @override
  void onInit() {
    super.onInit();
    initUser();
  }

  /// 初始化用户信息
  void initUser() {
    // 从storage中获取isLogin
    _isLogin.value = StorageService.to.getBool(StorageEnum.isLogin.name);

    if (_isLogin.value) {
      // 从storage中获取token
      _token.value = StorageService.to.getString(StorageEnum.tokenKey.name);

      // 从storage中获取userInfo
      final userInfoOffline =
          StorageService.to.getString(StorageEnum.userInfo.name);
      if (userInfoOffline.isNotEmpty) {
        _userInfo(UserModel.fromJson(jsonDecode(userInfoOffline)));
      }
    }
  }

  /// 登录
  void handleLogin(Map<String, dynamic> data) async {
    try {
      // UserInfoModel u = await UserApi.login(data);
      UserModel u = UserModel(
        id: '1',
        username: 'fjj',
        accessToken: '111111111',
      );
      _userInfo(u);
      _token.value = u.accessToken ?? '';
      _isLogin.value = true;
      StorageService.to.setString(StorageEnum.userInfo.name, jsonEncode(u));
      StorageService.to.setString(StorageEnum.tokenKey.name, _token.value);
      StorageService.to.setBool(StorageEnum.isLogin.name, _isLogin.value);
      Loading.showSuccess('登录成功');
      Get.offAndToNamed(AppRoutes.tabs);
    } catch (e) {
      print('login---$e');
    }
  }

  /// 退出登录
  void handleLogout([bool isExpire = false]) async {
    try {
      if (!isExpire) {
        // await UserApi.logout();
      }
      UserModel u = UserModel(
        id: '',
        username: '',
        accessToken: '',
      );
      _userInfo(u);
      _token.value = '';
      _isLogin.value = false;
      StorageService.to.setString(StorageEnum.userInfo.name, jsonEncode(u));
      StorageService.to.setString(StorageEnum.tokenKey.name, _token.value);
      StorageService.to.setBool(StorageEnum.isLogin.name, _isLogin.value);
      Loading.showSuccess('退出成功');
      Get.offAndToNamed(AppRoutes.login);
    } catch (e) {
      print('logout---$e');
    }
  }
}
