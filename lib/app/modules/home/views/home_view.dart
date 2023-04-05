import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:sudoku_classic/app/data/theme/theme_color_1.dart';

import '../controllers/home_controller.dart';
import '../widgets/level_map.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
     
    return Scaffold(
        appBar: AppBar(
          title: const Text('HomeView'),
          centerTitle: true,
          actions: [
            Obx(
              () => IconButton(
                onPressed: () {
                  controller.themeController.isLight.value =
                      !controller.themeController.isLight.value;
                  controller.themeController.setTheme();
                  Get.changeTheme(controller.themeController.isLight.value
                      ? CustomeThemeOne().lightTheme
                      : CustomeThemeOne().darkTheme);
                  // controller.update();
                },
                icon: Icon(controller.themeController.isLight.value
                    ? Icons.brightness_2
                    : Icons.sunny),
              ),
            )
          ],
        ),
        //   backgroundColor: Colors.limeAccent,
        body: GameLevelMap(


          levelWidgets: const [
            Text("data0"),
            Text("data1"),
            Text("data2"),
            Text("data3"),
            Text("data4"),
            Text("data5"),
            Text("data6"),
            Text("data7"),
            Text("data8"),
            Text("data9"),
            Text("data10"),
            Text("data11"),
            Text("data12"),
            Text("data12"),
            Text("data12"),
            Text("data"),
            Text("data"),
            Text("data"),
            Text("data"),
            Text("data"),

          ],
        )


        );
  }
}
