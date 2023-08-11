import 'package:flutter_demo/common/router/app_routes.dart';
import 'package:flutter_demo/common/router/auth_middleware.dart';
import 'package:flutter_demo/pages/login/binding.dart';
import 'package:flutter_demo/pages/login/view.dart';
import 'package:flutter_demo/pages/tabs/binding.dart';
import 'package:flutter_demo/pages/tabs/view.dart';
import 'package:get/get.dart';

class AppPages {
  static String initialRoute = AppRoutes.tabs;
  static final routes = [
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.tabs,
      page: () => const TabsPage(),
      binding: TabsBinding(),
      middlewares: [AuthMiddleware()],
    ),
  ];
}
