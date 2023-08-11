import 'package:flutter_demo/common/router/app_routes.dart';
import 'package:flutter_demo/common/router/auth_middleware.dart';
import 'package:flutter_demo/pages/home/binding.dart';
import 'package:flutter_demo/pages/home/view.dart';
import 'package:flutter_demo/pages/login/binding.dart';
import 'package:flutter_demo/pages/login/view.dart';
import 'package:get/get.dart';

class AppPages {
  static String initialRoute = AppRoutes.home.path;
  static final routes = [
    GetPage(
      name: AppRoutes.login.path,
      page: () => const LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.home.path,
      page: () => const HomePage(),
      binding: HomeBinding(),
      middlewares: [AuthMiddleware()],
    ),
  ];
}
