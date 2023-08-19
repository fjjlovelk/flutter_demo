import 'package:dio/dio.dart';
import 'package:flutter_demo/common/models/file_model.dart';
import 'package:flutter_demo/common/models/user_model.dart';
import 'package:flutter_demo/common/utils/http.dart';

class UserApi {
  /// 登录
  static Future<UserModel> login(Map<String, dynamic> data) async {
    var response = await HttpUtil().post('/user/login', data: data);
    return UserModel.fromJson(response);
  }

  /// 退出登录
  static Future<UserModel> logout() async {
    return await HttpUtil().post('/user/logout');
  }

  /// 文件上传
  static Future<FileModel> upload(
    Map<String, dynamic> data, {
    ProgressCallback? onSendProgress,
    CancelToken? cancelToken,
  }) async {
    var response = await HttpUtil().postForm(
      '/upload/single',
      data: data,
      onSendProgress: onSendProgress,
      cancelToken: cancelToken,
    );
    return FileModel.fromJson(response);
  }
}
