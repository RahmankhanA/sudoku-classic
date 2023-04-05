import 'package:flutter/cupertino.dart';

class MapLinePainter2 extends CustomPainter {
  Color color;
  double stroke;
  MapLinePainter2(this.color, this.stroke);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke;

    var path = Path();

    path.moveTo(size.width - 50, 0);

    path.quadraticBezierTo(size.width - 50, size.height * 0.5, size.width - 100,
        size.height * 0.5);
    path.lineTo(100, size.height * .5);
    path.quadraticBezierTo(50, size.height * .5, 50, size.height);
    canvas.drawPath(path, paint);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
