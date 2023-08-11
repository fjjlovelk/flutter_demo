import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo/common/services/storage_service.dart';
import 'package:flutter_demo/common/store/user.dart';
import 'package:flutter_demo/common/utils/loading.dart';
import 'package:get/get.dart';

/// 全局静态数据
class Global {
  /// 初始化
  static Future<void> init() async {
    // 在系统和flutter通信前进行自定义方法
    WidgetsFlutterBinding.ensureInitialized();
    // 固定App方向为上，即不受横屏影响
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    // 设置系统UI
    setSystemUi();
    // 加载loading实例
    Loading();
    // 注入StorageService
    await Get.putAsync<StorageService>(() => StorageService().init());
    // 注入UserStore
    Get.put<UserStore>(UserStore());
  }

  /// 设置系统UI
  static void setSystemUi() {
    if (GetPlatform.isAndroid) {
      SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      );
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
  }
}
