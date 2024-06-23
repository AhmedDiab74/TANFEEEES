
import 'package:flutter/material.dart';
import 'dart:math' as math;

double deg2rad(double deg) => deg * math.pi / 180;

double rad2deg(double rad) => rad * 180 / math.pi;

class CircleBorderwith4Color extends CustomPainter {
  final double borderThinckness;
  final double gap;

  final Color bottomRightColor;
  final Color bottomLeftColor;
  final Color topRightColor;
  final Color topLeftColor;

  CircleBorderwith4Color({
    required this.gap,
    required this.borderThinckness,
    required this.bottomLeftColor,
    required this.bottomRightColor,
    required this.topLeftColor,
    required this.topRightColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    /// line testing helper
    // Paint herlperPaint = Paint()
    //   ..color = Colors.black
    //   ..strokeCap = StrokeCap.square
    //   ..style = PaintingStyle.stroke
    //   ..strokeWidth = borderThinckness;

    // canvas.drawLine(Offset(size.height / 2, 0),
    //     Offset(size.height / 2, size.width), herlperPaint);

    // canvas.drawLine(Offset(0, size.height / 2),
    //     Offset(size.height, size.height / 2), herlperPaint);

    Paint paint_TR = Paint()
      ..color = topRightColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderThinckness;

    Paint paint_BR = Paint()
      ..color = bottomRightColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderThinckness;

    Paint paint_BL = Paint()
      ..color = bottomLeftColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderThinckness;

    Paint paint_TL = Paint()
      ..color = topLeftColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderThinckness;

    ///Bottom Right:: ok
    canvas.drawArc(
        Rect.fromCenter(center: center, width: size.width, height: size.height),
        deg2rad(0 + gap),
        deg2rad(90 - (gap * 2)),
        false,
        paint_BR);

    ///BottomLeft :: Ok
    canvas.drawArc(
        Rect.fromCenter(center: center, width: size.width, height: size.height),
        deg2rad(90 + gap),
        
        deg2rad(90 - (gap * 2)),
        
        false,
        paint_BL);

    // /TopLeft
    canvas.drawArc(
        Rect.fromCenter(center: center, width: size.width, height: size.height),
        deg2rad(180 + gap),
        deg2rad(90 - (gap * 2)),
        false,
        paint_TL);

    ///Top Right :: OK
    canvas.drawArc(
        Rect.fromCenter(center: center, width: size.width, height: size.height),
        deg2rad(270 + gap),
        deg2rad(90 - (gap * 2)),
        false,
        paint_TR);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
