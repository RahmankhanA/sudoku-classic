import 'package:flutter/material.dart';

class CustomCalendar extends StatelessWidget {
  final DateTime selectedDate;

  const CustomCalendar({super.key, required this.selectedDate});

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(color: Colors.grey),
      children: List.generate(
        6,
        (rowIndex) => TableRow(
          children: List.generate(
            7,
            (colIndex) {
              final cellIndex = rowIndex * 7 + colIndex;
              final cellDate = DateTime(
                  selectedDate.year, selectedDate.month, cellIndex + 1);
              final cellIcon = getIconForDate(cellDate);

              return TableCell(
                child: InkWell(
                  onTap: () {
                    // Do something when the cell is tapped
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('${cellDate.day}',
                          style: const TextStyle(fontSize: 18)),
                      const SizedBox(height: 8),
                      Icon(cellIcon),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  IconData getIconForDate(DateTime date) {
    // TODO: Implement a logic to determine the icon for a given date
    return Icons.star;
  }
}
