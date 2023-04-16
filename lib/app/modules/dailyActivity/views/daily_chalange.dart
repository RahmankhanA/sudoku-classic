import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class DailyChallengeCalendar extends StatefulWidget {
  const DailyChallengeCalendar({super.key});

  @override
  _DailyChallengeCalendarState createState() => _DailyChallengeCalendarState();
}

class _DailyChallengeCalendarState extends State<DailyChallengeCalendar> {
  // late CalendarController _calendarController;
  final List<Challenge> _challenges = [
    Challenge(
      title: 'Challenge 1',
      description: 'Complete 50 push-ups.',
      date: DateTime(2023, 4, 17),
    ),
    Challenge(
      title: 'Challenge 2',
      description: 'Read for 30 minutes.',
      date: DateTime(2023, 4, 18),
    ),
    Challenge(
      title: 'Challenge 3',
      description: 'Write a blog post.',
      date: DateTime(2023, 4, 19),
    ),
  ];

  @override
  void initState() {
    super.initState();
    // _calendarController = CalendarController();
  }

  @override
  void dispose() {
    // _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Challenge Calendar'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TableCalendar(
            firstDay: DateTime(1900),
            focusedDay: DateTime.now(),
            lastDay: DateTime(3900),

            // calendarController: _calendarController,
            startingDayOfWeek: StartingDayOfWeek.monday,
            calendarFormat: CalendarFormat.month,
            holidayPredicate: (day) {
              if (day.day % 3 == 0) {
                return true;
              }
              return false;
            },

            calendarStyle: const CalendarStyle(
              todayDecoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
              markersMaxCount: 1,
              // markersPositionBottom: -15,

              markersAlignment: Alignment.bottomCenter,
              markersOffset: PositionedOffset(),
              markerDecoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.redAccent,
              ),
            ),
            headerStyle: const HeaderStyle(
              titleCentered: true,
              formatButtonVisible: false,
              // formatButtonDecoration: BoxDecoration(
              //   color: Colors.orange,
              //   borderRadius: BorderRadius.circular(20.0),
              // ),
              formatButtonTextStyle: TextStyle(color: Colors.white),
            ),
            calendarBuilders: CalendarBuilders(
              // todayBuilder: (context, day, focusedDay) {
              //   return Column(
              //     children: [
              //       Text(focusedDay.day.toString(),
              //           style: const TextStyle(fontSize: 18)),
              //       const Icon(
              //         Icons.star,
              //         color: Colors.amberAccent,
              //       ),
              //     ],
              //   );
              // },
              holidayBuilder: (context, day, focusedDay) {
                return Column(
                  children: [
                    Text(focusedDay.day.toString(),
                        style: const TextStyle(fontSize: 18)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.star,
                          color: Colors.amberAccent,
                          size: 8.0,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.amberAccent,
                          size: 8.0,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.amberAccent,
                          size: 8.0,
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
          // CustomCalendar(selectedDate: DateTime.now(),),
          const SizedBox(height: 16.0),
          Expanded(
            child: ListView.builder(
              itemCount: _challenges.length,
              itemBuilder: (context, index) {
                final challenge = _challenges[index];
                return ListTile(
                  title: Text(challenge.title),
                  subtitle: Text(challenge.description),
                  trailing: Text(
                    challenge.date
                        .toString()
                        .split(' ')[0]
                        .replaceAll('-', '/'),
                    // '${challenge.date.day}/${challenge.date.month}/${challenge.date.year}',
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Challenge {
  String title;
  String description;
  DateTime date;

  Challenge(
      {required this.title, required this.description, required this.date});
}
