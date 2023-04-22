// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// class Schedule extends StatefulWidget {
//   const Schedule({Key? key}) : super(key: key);

//   @override
//   State<Schedule> createState() => _ScheduleState();
// }

// class _ScheduleState extends State<Schedule> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(20),
//       width: double.infinity,
//       decoration: BoxDecoration(
//           color: Colors.black45, borderRadius: BorderRadius.circular(10)),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: const [
//           Icon(CupertinoIcons.calendar, size: 15, color: Colors.white),
//           SizedBox(
//             width: 30,
//           ),
//           Text(
//             "Monday, 12/04/2023",
//             style: TextStyle(color: Colors.white),
//           ),
//           SizedBox(
//             width: 30,
//           ),
//           Icon(
//             CupertinoIcons.alarm,
//             size: 15,
//             color: Colors.white,
//           ),
//           SizedBox(
//             width: 30,
//           ),
//         ],
//       ),
//     );
//   }
// }