import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('登录页')),
      body: const Center(
        child: Text('登录页'),
      ),
    );
  }
}
