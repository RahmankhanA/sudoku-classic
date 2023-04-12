import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sudoku_classic/app/modules/profile/controllers/profile_controller.dart';

class MyBubble extends StatefulWidget {
  final double radius;
  final Color color;
  final int number;
  final int currentLevel;
  final bool isLocked;
  final String gameType;

  const MyBubble({
    super.key,
    required this.radius,
    required this.color,
    required this.number,
    required this.currentLevel,
    required this.isLocked,
    required this.gameType,
  });

  @override
  // ignore: library_private_types_in_public_api
  _MyBubbleState createState() => _MyBubbleState();
}

class _MyBubbleState extends State<MyBubble> {
  ProfileController profileController = Get.find<ProfileController>();
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        log("index: ${widget.number}");
        if (widget.number <= widget.currentLevel) {
          await Get.toNamed('/game',
              arguments: {"gameLevel": widget.number, "Type": widget.gameType});

          profileController.update();
        }
      },
      child: CustomPaint(
        painter: BubblePainter(
          radius: widget.radius,
          color: widget.color,
          number: widget.number,
          currentLevel: widget.currentLevel,
          isLocked: widget.isLocked,
        ),
      ),
    );
  }
}

class BubblePainter extends CustomPainter {
  final double radius;
  final Color color;
  final int number;
  final int currentLevel;
  final bool isLocked;

  BubblePainter(
      {required this.radius,
      required this.color,
      required this.number,
      required this.currentLevel,
      required this.isLocked});

  @override
  void paint(Canvas canvas, Size size) async {
    final center = Offset(size.width / 2, size.height / 2);
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path()
      ..addOval(Rect.fromCircle(center: center, radius: radius));

    final rect = Rect.fromCircle(center: center, radius: radius);

    final gradient = RadialGradient(
      colors: [Colors.white, Colors.white.withOpacity(0.2)],
      stops: const [0.6, 1],
    );

    final paint2 = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.fill;

    canvas.drawPath(path, paint);
    canvas.drawCircle(center, radius * 0.7, paint2);
    Image image = currentLevel < number
        ? Image.asset('assets/images/locked_black.png')
        : (currentLevel > number
            ? Image.asset('assets/images/completed_black.png')
            : Image.asset('assets/images/current_black.png'));

    image.image.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener(
        (info, _) {
          // canvas.drawImage(
          //     info.image,
          //     center- const Offset(20, 20),
          //     //  center - Offset(info.image.width / 2.0, info.image.height / 2),
          //     paint);
          paintImage(
              canvas: canvas,
              rect: Rect.fromCircle(center: const Offset(30, 30), radius: 30),
              // rect: Rect.fromCircle(center: center, radius: 30),
              image: info.image);
        },
      ),
    );

// canvas.drawImage(image, offset, paint)
    final textPainter = TextPainter(
      text: TextSpan(
        text: number.toString(),
        style: TextStyle(
          color: Colors.black,
          fontSize: radius * 0.5,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    textPainter.paint(
        canvas, center - Offset(textPainter.width / 2, textPainter.height / 2));
  }

  @override
  bool shouldRepaint(BubblePainter oldDelegate) {
    return false;
  }
}
