import 'package:flutter/material.dart';
import 'dart:math' as math;

class CirclePainter extends CustomPainter {
  final Color color;

  CirclePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    double centerX = size.width / 2;
    double centerY = size.height / 2;
    double radius = math.min(size.width, size.height) / 2;

    canvas.drawCircle(Offset(centerX, centerY), radius, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class CircleWidget extends StatelessWidget {
  final Color color;
  final double size;
  const CircleWidget({super.key, required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: CirclePainter(color: color),
      size: Size(size, size),
    );
  }
}
