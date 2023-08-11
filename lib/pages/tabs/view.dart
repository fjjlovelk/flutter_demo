import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

class TabsPage extends GetView<TabsController> {
  const TabsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller.state.pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: controller.onPageChanged,
        children: controller.state.pages,
      ),
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
