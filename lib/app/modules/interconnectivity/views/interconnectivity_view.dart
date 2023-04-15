import 'package:flutter/material.dart';

class ConfirmationDialogForInternet extends StatelessWidget {
  final String message;
  final Function onConfirm;

  const ConfirmationDialogForInternet(
      {super.key, required this.message, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      title: const Text(
        'Confirmation',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20.0,
        ),
      ),
      content: Text(
        message,
        style: const TextStyle(
          fontSize: 16.0,
        ),
      ),
      // actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: [
        // ElevatedButton(
        //   onPressed: () => Navigator.pop(context),
        //   // icon: const Icon(
        //   //   Icons.backspace,
        //   // ),
        //   child: const Text(
        //     'Cancel',
        //     style: TextStyle(
        //       // color: Colors.red,
        //       fontWeight: FontWeight.bold,
        //       fontSize: 16.0,
        //     ),
        //   ),
        // ),
        ElevatedButton(
          onPressed: () => onConfirm(),
          // icon: const Icon(Icons.done),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: const Text(
              'Enable',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
