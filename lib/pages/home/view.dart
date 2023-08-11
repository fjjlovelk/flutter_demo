import 'package:flutter/material.dart';
import 'package:flutter_demo/pages/home/controller.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(children: []),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: controller.state.currentTab,
          selectedFontSize: 12.0,
          type: BottomNavigationBarType.fixed,
          items: controller.state.bottomTabs,
          onTap: controller.bottomNavigationBarTab,
        ),
      ),
    );
  }
}
