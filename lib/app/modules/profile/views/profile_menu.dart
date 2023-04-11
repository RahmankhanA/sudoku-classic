import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    Key? key,
    required this.title,
    required this.level,
  }) : super(key: key);

  final String title;
  final int level;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
        ),
        child: const Icon(LineAwesomeIcons.alternate_sort_amount_up),
      ),
      title: Text(title, style: Theme.of(context).textTheme.bodyLarge?.apply()),
      trailing: Text(
        level.toString(),
        style: const TextStyle(
          fontSize: 25,
        ),
      ),
    );
  }
}

// class ProfileMenuWidget extends StatelessWidget {
//   const ProfileMenuWidget({
//     Key? key,
//     required this.title,
//     required this.icon,
//     required this.onPress,
//     this.endIcon = true,
//     this.textColor,
//   }) : super(key: key);

//   final String title;
//   final IconData icon;
//   final VoidCallback onPress;
//   final bool endIcon;
//   final Color? textColor;

//   @override
//   Widget build(BuildContext context) {
//     var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;


//     return ListTile(
//       onTap: onPress,
//       leading: Container(
//         width: 40,
//         height: 40,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(100),

//         ),
//         child: Icon(icon, ),
//       ),
//       title: Text(title,
//           style:
//               Theme.of(context).textTheme.bodyLarge?.apply(color: textColor)),
//       trailing: endIcon
//           ? Container(
//               width: 30,
//               height: 30,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(100),
//                 color: Colors.grey.withOpacity(0.1),
//               ),
//               child: const Icon(LineAwesomeIcons.angle_right,
//                   size: 18.0, color: Colors.grey))
//           : null,
//     );
//   }
// }
