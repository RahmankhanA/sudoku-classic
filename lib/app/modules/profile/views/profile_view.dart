import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudoku_classic/app/modules/profile/views/profile_menu.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back_ios)),
        title:
            Text("profile", style: Theme.of(context).textTheme.headlineMedium),
        centerTitle: true,
        actions: const [
          //  IconButton(
          //       onPressed: () {
          //         controller.themeController.setTheme(
          //             isLight: !controller.themeController.isLight.value);

          //         Get.changeTheme(controller.themeController.isLight.value
          //             ? CustomeThemeOne().lightTheme
          //             : CustomeThemeOne().darkTheme);
          //       },
          //       icon: Icon(controller.themeController.isLight.value
          //           ? LineAwesomeIcons.moon
          //           : LineAwesomeIcons.sun))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              /// -- IMAGE
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: const Image(
                            image: AssetImage('assets/images/Boy Study.png'))),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text("ProfileHeading",
                  style: Theme.of(context).textTheme.headlineMedium),
              Text("Score : ${controller.user.score}",
                  style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 20),

              /// -- BUTTON
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {},
                  // onPressed: () => Get.to(() => const UpdateProfileScreen()),
                  style: ElevatedButton.styleFrom(
                      // backgroundColor: tPrimaryColor,
                      side: BorderSide.none,
                      shape: const StadiumBorder()),
                  child: const Text("EditProfile", style: TextStyle()),
                ),
              ),
              const SizedBox(height: 30),
              const Divider(),
              const SizedBox(height: 10),

              /// -- MENU

              ProfileMenuWidget(
                title: "Easy",
                level: controller.user.currentEasyLevel,
              ),
              ProfileMenuWidget(
                title: "Medium",
                level: controller.user.currentMediumLevel,
              ),
              ProfileMenuWidget(
                title: "Hard",
                level: controller.user.currentHardLevel,
              ),

              const Divider(),
              const SizedBox(height: 10),
              // ProfileMenuWidget(
              //     title: "Information",
              //     icon: LineAwesomeIcons.info,
              //     onPress: () {}),
              // ProfileMenuWidget(
              //     title: "Logout",
              //     icon: LineAwesomeIcons.alternate_sign_out,
              //     textColor: Colors.red,
              //     endIcon: false,
              //     onPress: () {
              //       Get.defaultDialog(
              //         title: "LOGOUT",
              //         titleStyle: const TextStyle(fontSize: 20),
              //         content: const Padding(
              //           padding: EdgeInsets.symmetric(vertical: 15.0),
              //           child: Text("Are you sure, you want to Logout?"),
              //         ),
              //         confirm: Expanded(
              //           child: ElevatedButton(
              //             onPressed: () {},
              //             //     AuthenticationRepository.instance.logout(),
              //             style: ElevatedButton.styleFrom(
              //                 backgroundColor: Colors.redAccent,
              //                 side: BorderSide.none),
              //             child: const Text("Yes"),
              //           ),
              //         ),
              //         cancel: OutlinedButton(
              //             onPressed: () => Get.back(), child: const Text("No")),
              //       );
              //     }),
            ],
          ),
        ),
      ),
    );
  }
}
