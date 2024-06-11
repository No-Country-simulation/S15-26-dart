import 'package:flutter/material.dart';

class DashedBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..color = Colors.black;

    const dashWidth = 5.0;
    const dashSpace = 3.0;
    const startX = 0.0;
    final startY = size.height / 2;
    final endX = size.width;
    final endY = size.height / 2;

    for (double x = startX; x < endX; x += dashWidth + dashSpace) {
      canvas.drawLine(Offset(x, startY), Offset(x + dashWidth, endY), paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
