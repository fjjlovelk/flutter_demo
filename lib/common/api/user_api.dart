import 'package:flutter_demo/common/models/user_info.dart';
import 'package:flutter_demo/common/utils/http.dart';

class UserApi {
  /// 登录
  static Future<UserInfoModel> login(Map<String, dynamic> data) async {
    var response = await HttpUtil().post('/login', data: data);
    return UserInfoModel.fromJson(response);
  }
}
