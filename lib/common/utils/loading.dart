import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class Loading {
  Loading() {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 1000)
      ..indicatorType = EasyLoadingIndicatorType.ring
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 35.0
      ..lineWidth = 2
      ..radius = 10.0
      ..progressColor = Colors.white
      ..backgroundColor = Colors.black.withOpacity(0.7)
      ..indicatorColor = Colors.white
      ..textColor = Colors.white
      ..userInteractions = true
      ..dismissOnTap = false;
  }

  /// 显示loading
  static void show([String text = '加载中...']) {
    EasyLoading.instance.userInteractions = false;
    EasyLoading.show(status: text, maskType: EasyLoadingMaskType.black);
  }

  /// 隐藏loading
  static void dismiss() {
    EasyLoading.instance.userInteractions = true;
    EasyLoading.dismiss();
  }

  /// toast
  static void showToast(String text) {
    EasyLoading.instance.userInteractions = true;
    EasyLoading.showToast(text, maskType: EasyLoadingMaskType.none);
  }

  /// 成功
  static void showSuccess(String text) {
    EasyLoading.instance.userInteractions = true;
    EasyLoading.showSuccess(text, maskType: EasyLoadingMaskType.none);
  }

  /// 失败
  static void showError(String text) {
    EasyLoading.instance.userInteractions = true;
    EasyLoading.showError(text, maskType: EasyLoadingMaskType.none);
  }

  /// 信息
  static void showInfo(String text) {
    EasyLoading.instance.userInteractions = true;
    EasyLoading.showInfo(text, maskType: EasyLoadingMaskType.none);
  }
}
