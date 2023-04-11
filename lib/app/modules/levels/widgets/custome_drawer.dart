import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
                // color: Colors.blue,
                ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 120,
                  height: 120,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: const Image(
                          image: AssetImage('assets/images/Boy Study.png'))),
                ),
                GestureDetector(
                  onTap: () => Get.back(),
                  child: const Icon(Icons.close),
                )
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Update the state of the app.
              // ...
              // log(theme.appBarTheme.toString());
              Get.back();
              Get.toNamed('/setting');
            },
          ),
          ListTile(
            leading: const Icon(Icons.person_3),
            title: const Text('profile'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Get.back();
              Get.toNamed('/profile');
              // Update the state of the app.
              // ...
            },
          ),
        ],
      ),
    );
  }
}
