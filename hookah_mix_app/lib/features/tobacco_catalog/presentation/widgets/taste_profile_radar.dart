import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hookah_mix_master/features/tobacco_catalog/domain/entities/taste_profile.dart';

const _labels = ['Sweet', 'Sour', 'Fresh', 'Spicy', 'Bitter', 'Floral'];

class TasteProfileRadar extends StatelessWidget {
  const TasteProfileRadar({super.key, required this.profile, this.size = 200});

  final TasteProfile profile;
  final double size;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _RadarPainter(
          values: profile.values,
          fillColor: cs.primary.withValues(alpha: 0.25),
          strokeColor: cs.primary,
          gridColor: cs.outline.withValues(alpha: 0.3),
          labelColor: cs.onSurfaceVariant,
        ),
      ),
    );
  }
}

class _RadarPainter extends CustomPainter {
  _RadarPainter({
    required this.values,
    required this.fillColor,
    required this.strokeColor,
    required this.gridColor,
    required this.labelColor,
  });

  final List<int> values;
  final Color fillColor;
  final Color strokeColor;
  final Color gridColor;
  final Color labelColor;

  static const int _sides = 6;
  static const int _scale = 10;
  static const int _rings = 5;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 * 0.7;

    _drawGrid(canvas, center, radius);
    _drawData(canvas, center, radius);
    _drawLabels(canvas, center, radius, size);
  }

  void _drawGrid(Canvas canvas, Offset center, double radius) {
    final paint = Paint()
      ..color = gridColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    for (int ring = 1; ring <= _rings; ring++) {
      final r = radius * ring / _rings;
      final path = Path();
      for (int i = 0; i < _sides; i++) {
        final angle = _angleForIndex(i);
        final point = Offset(center.dx + r * cos(angle), center.dy + r * sin(angle));
        if (i == 0) {
          path.moveTo(point.dx, point.dy);
        } else {
          path.lineTo(point.dx, point.dy);
        }
      }
      path.close();
      canvas.drawPath(path, paint);
    }

    for (int i = 0; i < _sides; i++) {
      final angle = _angleForIndex(i);
      canvas.drawLine(
        center,
        Offset(center.dx + radius * cos(angle), center.dy + radius * sin(angle)),
        paint,
      );
    }
  }

  void _drawData(Canvas canvas, Offset center, double radius) {
    final fillPaint = Paint()
      ..color = fillColor
      ..style = PaintingStyle.fill;
    final strokePaint = Paint()
      ..color = strokeColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final path = Path();
    for (int i = 0; i < _sides; i++) {
      final value = i < values.length ? values[i] : 0;
      final ratio = value / _scale;
      final r = radius * ratio.clamp(0.0, 1.0);
      final angle = _angleForIndex(i);
      final point = Offset(center.dx + r * cos(angle), center.dy + r * sin(angle));
      if (i == 0) {
        path.moveTo(point.dx, point.dy);
      } else {
        path.lineTo(point.dx, point.dy);
      }
    }
    path.close();
    canvas.drawPath(path, fillPaint);
    canvas.drawPath(path, strokePaint);
  }

  void _drawLabels(Canvas canvas, Offset center, double radius, Size size) {
    const style = TextStyle(fontSize: 10);
    final labelRadius = radius * 1.25;

    for (int i = 0; i < _sides; i++) {
      final angle = _angleForIndex(i);
      final x = center.dx + labelRadius * cos(angle);
      final y = center.dy + labelRadius * sin(angle);
      final label = i < _labels.length ? _labels[i] : '';

      final span = TextSpan(
        text: label,
        style: style.copyWith(color: labelColor),
      );
      final painter = TextPainter(text: span, textDirection: TextDirection.ltr)..layout();

      painter.paint(canvas, Offset(x - painter.width / 2, y - painter.height / 2));
    }
  }

  double _angleForIndex(int i) => -pi / 2 + (2 * pi / _sides) * i;

  @override
  bool shouldRepaint(_RadarPainter old) =>
      old.values != values || old.fillColor != fillColor || old.strokeColor != strokeColor;
}
