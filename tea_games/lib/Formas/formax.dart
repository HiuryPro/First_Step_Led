import 'package:flutter/material.dart';

class XPainter extends CustomPainter {
  final Paint _paint;

  XPainter(Color color)
      : _paint = Paint()
          ..color = color
          ..strokeWidth = 15
          ..strokeCap = StrokeCap.round;

  @override
  void paint(Canvas canvas, Size size) {
    final double centerX = size.width / 2;
    final double centerY = size.height / 2;
    final double halfWidth = size.width / 2;
    final double halfHeight = size.height / 2;

    canvas.drawLine(
      Offset(centerX - halfWidth, centerY - halfHeight),
      Offset(centerX + halfWidth, centerY + halfHeight),
      _paint,
    );
    canvas.drawLine(
      Offset(centerX - halfWidth, centerY + halfHeight),
      Offset(centerX + halfWidth, centerY - halfHeight),
      _paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class XWidget extends StatelessWidget {
  final Color color;
  final double size;

  const XWidget({Key? key, required this.color, required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: XPainter(color),
      size: Size(size, size),
    );
  }
}
