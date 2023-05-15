import 'package:flutter/material.dart';
import 'dart:math' as math;

class StarPainter extends CustomPainter {
  final Color color;

  StarPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    double centerX = size.width / 2;
    double centerY = size.height / 2;
    double radius = math.min(size.width, size.height) / 2;

    // calcula as posições dos dez pontos da estrela
    List<Offset> starPoints = [];
    double angle =
        -math.pi / 2; // ângulo inicial é 270 graus (apontando para cima)
    double deltaAngle = 2 * math.pi / 5; // variação angular entre cada ponto
    for (int i = 0; i < 5; i++) {
      double x = centerX + math.cos(angle) * radius;
      double y = centerY + math.sin(angle) * radius;
      starPoints.add(Offset(x, y));
      angle += deltaAngle;
      x = centerX + math.cos(angle) * radius / 2;
      y = centerY + math.sin(angle) * radius / 2;
      starPoints.add(Offset(x, y));
      angle += deltaAngle;
    }

    // define o Path da estrela
    Path path = Path();
    path.moveTo(starPoints[0].dx, starPoints[0].dy);
    for (int i = 1; i < starPoints.length; i++) {
      path.lineTo(starPoints[i].dx, starPoints[i].dy);
    }
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class StarWidget extends StatelessWidget {
  final Color color;
  final double size;

  const StarWidget({super.key, required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: StarPainter(color: color),
      size: Size(size, size),
    );
  }
}
