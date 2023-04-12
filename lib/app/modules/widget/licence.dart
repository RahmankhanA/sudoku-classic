import 'package:flutter/material.dart';

class SimpleLicence extends StatelessWidget {
  const SimpleLicence({super.key});

  @override
  Widget build(BuildContext context) {
    return  LicensePage(
      applicationName: 'Sudoku Classic',
      applicationIcon: Padding(
        padding: const EdgeInsets.all(8),
        child: Image.asset('assets/icon/icon_foreground.png', width: 48, height: 48),
      ),
      applicationVersion: '0.0.1',
      applicationLegalese: 'Copyright ${DateTime.now().year} My Company',
    );

  }
}