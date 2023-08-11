import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeState {
  final RxInt _currentTab = 0.obs;

  List<BottomNavigationBarItem> bottomTabs = const [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: '主页'),
    BottomNavigationBarItem(icon: Icon(Icons.person), label: '我的'),
  ];

  int get currentTab => _currentTab.value;

  set currentTab(int value) => _currentTab.value = value;
}
