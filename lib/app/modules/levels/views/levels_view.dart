import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/levels_controller.dart';

class LevelsView extends GetView<LevelsController> {
  const LevelsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LevelsView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'LevelsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
