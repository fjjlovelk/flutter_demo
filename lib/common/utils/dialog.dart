import 'package:flutter/cupertino.dart';
import 'package:flutter_demo/common/utils/loading.dart';
import 'package:get/get.dart';

class DialogUtil {
  /// cupertino风格的dialog
  static void show({
    bool barrierDismissible = true,
    String title = '提示',
    String content = '内容',
    bool cancelButtonShow = true,
    bool confirmButtonShow = true,
    String cancelButtonText = '取消',
    String confirmButtonText = '确认',
    bool isCloseAfterPress = true,
    void Function()? onCancel,
    void Function()? onConfirm,
  }) {
    if (Get.context == null) {
      Loading.showError('context有误！');
      return;
    }
    List<CupertinoButton> actions = [];
    actions.addIf(
      cancelButtonShow,
      CupertinoButton(
        onPressed: () {
          if (isCloseAfterPress) {
            Get.back();
          }
          if (onCancel != null) {
            onCancel();
          }
        },
        child: Text(cancelButtonText),
      ),
    );
    actions.addIf(
      confirmButtonShow,
      CupertinoButton(
        onPressed: () {
          if (isCloseAfterPress) {
            Get.back();
          }
          if (onConfirm != null) {
            onConfirm();
          }
        },
        child: Text(confirmButtonText),
      ),
    );
    showCupertinoDialog(
      context: Get.context!,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title),
        content: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Text(
            content,
            style: const TextStyle(fontSize: 14),
          ),
        ),
        actions: actions,
      ),
    );
  }
}
