import 'package:flutter/material.dart';
import 'package:flutter_demo/common/router/app_routes.dart';
import 'package:flutter_demo/common/store/user_store.dart';
import 'package:get/get.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if (UserStore.to.isLogin) {
      return null;
    }
    return const RouteSettings(name: AppRoutes.login);
  }
}
