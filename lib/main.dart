import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'common/router/app_pages.dart';
import 'global.dart';

void main() async {
  await Global.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return GetMaterialApp(
          title: "Application",
          initialRoute: AppPages.initialRoute,
          getPages: AppPages.routes,
          builder: EasyLoading.init(),
          debugShowCheckedModeBanner: false,
          defaultTransition: Transition.cupertino,
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            appBarTheme: const AppBarTheme(
              centerTitle: true,
              scrolledUnderElevation: 0,
            ),
          ),
        );
      },
    );
  }
}
