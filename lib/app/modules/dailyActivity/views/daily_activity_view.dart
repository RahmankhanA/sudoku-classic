import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/daily_activity_controller.dart';
import 'daily_chalange.dart';

class DailyActivityView extends GetView<DailyActivityController> {
  const DailyActivityView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('DailyActivityView'),
      //   centerTitle: true,
      // ),
      body: DailyChallengeCalendar(),
    );
  }
}
