import 'package:flutter/material.dart';

class LosangoPainter extends CustomPainter {
  final Color color;

  LosangoPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;

    final width = size.width;
    final height = size.height;

    final path = Path();
    path.moveTo(width / 2, 0);
    path.lineTo(width, height / 2);
    path.lineTo(width / 2, height);
    path.lineTo(0, height / 2);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(LosangoPainter oldDelegate) {
    return color != oldDelegate.color;
  }
}

class LosangoWidget extends StatelessWidget {
  final double size;
  final Color color;

  const LosangoWidget({Key? key, required this.size, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: LosangoPainter(color: color),
      size: Size(size, size),
    );
  }
}
