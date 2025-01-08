
import 'package:flutter/material.dart';

class DashedBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFD9D9D9)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    double dashWidth = 5, dashSpace = 5;
    double startX = 0;
    final space = (dashSpace + dashWidth);

    // Top border
    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += space;
    }

    startX = 0;
    // Bottom border
    while (startX < size.width) {
      canvas.drawLine(
          Offset(startX, size.height), Offset(startX + dashWidth, size.height), paint);
      startX += space;
    }

    double startY = 0;
    // Left border
    while (startY < size.height) {
      canvas.drawLine(Offset(0, startY), Offset(0, startY + dashWidth), paint);
      startY += space;
    }

    startY = 0;
    // Right border
    while (startY < size.height) {
      canvas.drawLine(
          Offset(size.width, startY), Offset(size.width, startY + dashWidth), paint);
      startY += space;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}