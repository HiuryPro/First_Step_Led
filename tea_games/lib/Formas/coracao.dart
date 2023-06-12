import 'package:flutter/material.dart';

class HeartPainter extends CustomPainter {
  final Color color;

  HeartPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    var path = Path();

    path.moveTo(size.width / 2, size.height * 0.35);

    path.cubicTo(
      size.width * 0.7,
      size.height * 0.1,
      size.width * 0.9,
      size.height * 0.3,
      size.width * 0.9,
      size.height * 0.5,
    );

    path.cubicTo(
      size.width * 0.9,
      size.height * 0.7,
      size.width * 0.6,
      size.height * 0.9,
      size.width * 0.5,
      size.height * 0.9,
    );

    path.cubicTo(
      size.width * 0.4,
      size.height * 0.9,
      size.width * 0.1,
      size.height * 0.7,
      size.width * 0.1,
      size.height * 0.5,
    );

    path.cubicTo(
      size.width * 0.1,
      size.height * 0.3,
      size.width * 0.3,
      size.height * 0.1,
      size.width / 2,
      size.height * 0.35,
    );

    // Deixar a parte inferior mais pontiaguda
    path.lineTo(size.width / 2, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class HeartWidget extends StatelessWidget {
  final Color color;
  final double size;

  const HeartWidget({Key? key, required this.size, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      child: CustomPaint(
        painter: HeartPainter(color: color),
      ),
    );
  }
}
