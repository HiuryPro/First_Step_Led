import 'package:flutter/material.dart';
import 'dart:math' as math;

class SquarePainter extends CustomPainter {
  final Color color;

  SquarePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    double squareSize = math.min(size.width, size.height);

    canvas.drawRect(Rect.fromLTWH(0, 0, squareSize, squareSize), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class SquareWidget extends StatelessWidget {
  final Color color;
  final double size;
  const SquareWidget({super.key, required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: SquarePainter(color: color),
      size: Size(size, size),
    );
  }
}
