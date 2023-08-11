import 'package:flutter/material.dart';
import 'package:flutter_demo/common/utils/keep_alive_wrapper.dart';
import 'package:flutter_demo/pages/home/view.dart';
import 'package:flutter_demo/pages/mine/view.dart';
import 'package:get/get.dart';

class TabsState {
  final RxInt _currentTab = 0.obs;

  final PageController pageController = PageController(initialPage: 0);

  final List<Widget> pages = const [
    KeepAliveWrapper(child: HomePage()),
    KeepAliveWrapper(child: MinePage()),
  ];

  final List<BottomNavigationBarItem> bottomTabs = const [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: '主页'),
    BottomNavigationBarItem(icon: Icon(Icons.person), label: '我的'),
  ];

  int get currentTab => _currentTab.value;

  set currentTab(int value) => _currentTab.value = value;
}
