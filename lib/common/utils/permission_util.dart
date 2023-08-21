import 'package:flutter_demo/common/utils/loading_util.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class PermissionUtil {
  /// 请求权限
  static Future<bool> _requestPermission(
    Permission permission,
    String message,
  ) async {
    PermissionStatus status = await permission.status;
    print(status.toString());
    // 准许、限制型准许
    if (status.isGranted || status.isLimited) {
      return true;
    }
    // 已拒绝
    if (status.isDenied) {
      // 重新请求
      PermissionStatus permissionStatus = await permission.request();
      if (permissionStatus.isGranted || permissionStatus.isLimited) {
        return true;
      }
      // 永久拒绝或拒绝弹框提示
      if (permissionStatus.isPermanentlyDenied || permissionStatus.isDenied) {
        LoadingUtil.showInfo(message);
        return false;
      }
      return false;
    }
    // 永久拒绝
    if (status.isPermanentlyDenied) {
      LoadingUtil.showInfo(message);
      return false;
    }
    return false;
  }

  /// 相册 权限检查和请求
  static Future<bool> photos({String message = '暂无相册权限，请前往设置开启权限'}) async {
    try {
      await AssetPicker.permissionCheck();
      return true;
    } catch (e) {
      LoadingUtil.showInfo(message);
      return false;
    }
    // Permission permission = Permission.photos;
    // if (Platform.isAndroid) {
    //   AndroidDeviceInfo androidInfo = await DeviceInfoPlugin().androidInfo;
    //   if (androidInfo.version.sdkInt < 33) {
    //     permission = Permission.storage;
    //   }
    // }
    // bool isGranted = await _requestPermission(permission, message);
    // return isGranted;
  }

  /// 相机 权限检查和请求
  static Future<bool> camera({String message = '暂无相机权限，请前往设置开启权限'}) async {
    bool isGranted = await _requestPermission(Permission.camera, message);
    return isGranted;
  }

  /// 麦克风 权限检查和请求
  static Future<bool> microphone({String message = '暂无麦克风权限，请前往设置开启权限'}) async {
    bool isGranted = await _requestPermission(Permission.microphone, message);
    return isGranted;
  }

  /// 手机存储 权限检查和请求
  static Future<bool> storage({String message = '暂无手机存储权限，请前往设置开启权限'}) async {
    bool isGranted = await _requestPermission(Permission.storage, message);
    return isGranted;
  }

  /// 媒体位置权限
  static Future<bool> accessMediaLocation(
      {String message = '暂无媒体位置权限，请前往设置开启权限'}) async {
    bool isGranted =
        await _requestPermission(Permission.accessMediaLocation, message);
    return isGranted;
  }
}
