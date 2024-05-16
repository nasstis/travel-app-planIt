import 'package:flutter/material.dart';

class BackgroundPainter extends CustomPainter {
  final Animation<double> animation;

  const BackgroundPainter(this.animation);

  Offset getOffset(Path path) {
    final pms = path.computeMetrics(forceClosed: false).elementAt(0);
    final length = pms.length;
    final offset = pms.getTangentForOffset(length * animation.value)!.position;
    return offset;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.maskFilter = const MaskFilter.blur(
      BlurStyle.normal,
      30,
    );
    drawShape2(canvas, size, paint, const Color(0xFF6B51BE));
    drawShape1(canvas, size, paint, const Color(0xFF9F8DD8));
    drawShape3(canvas, size, paint, const Color(0xFF4F3C8B));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != this;
  }

  void drawShape1(
    Canvas canvas,
    Size size,
    Paint paint,
    Color color,
  ) {
    paint.color = color;
    Path path = Path();

    path.moveTo(size.width, 0);
    path.quadraticBezierTo(
      size.width,
      size.height,
      size.width / 4.5,
      200,
    );

    final offset = getOffset(path);
    canvas.drawCircle(offset, 200, paint);
  }

  void drawShape2(
    Canvas canvas,
    Size size,
    Paint paint,
    Color color,
  ) {
    paint.color = color;
    Path path = Path();

    path.moveTo(size.width / 2, 230);
    path.quadraticBezierTo(
      size.width / 4.5,
      size.height / 6,
      size.width / 2,
      size.height * 2,
    );

    final offset = getOffset(path);
    canvas.drawCircle(offset, 150, paint);
  }

  void drawShape3(
    Canvas canvas,
    Size size,
    Paint paint,
    Color color,
  ) {
    paint.color = color;
    Path path = Path();

    path.moveTo(20, 20);
    path.quadraticBezierTo(
      size.width * 1.5,
      size.height * 1.5,
      size.width / 2,
      230,
    );

    final offset = getOffset(path);
    canvas.drawCircle(offset, 150, paint);
  }
}
