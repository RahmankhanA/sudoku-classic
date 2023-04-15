import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/setting_controller.dart';

class SettingView extends GetView<SettingController> {
  const SettingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: const [
            Text(
              '1. internet connectivity',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              '2. Test App',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              '3. signer',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
