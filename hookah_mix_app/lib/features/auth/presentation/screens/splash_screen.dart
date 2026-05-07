import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hookah_mix_master/core/extensions/context_extensions.dart';
import 'package:hookah_mix_master/core/router/routes.dart';
import 'package:hookah_mix_master/core/theme/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _hookahCtrl;
  late final AnimationController _glowCtrl;
  late final AnimationController _titleCtrl;
  late final AnimationController _smokeCtrl;
  late final AnimationController _bubbleCtrl;

  late final Animation<double> _hookahScale;
  late final Animation<double> _hookahFade;
  late final Animation<double> _glowOpacity;
  late final Animation<double> _glowScale;
  late final Animation<double> _titleFade;
  late final Animation<Offset> _titleSlide;

  @override
  void initState() {
    super.initState();

    _hookahCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 750),
    );
    _glowCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    );
    _titleCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _smokeCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat();
    _bubbleCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    )..repeat();

    _hookahScale = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _hookahCtrl, curve: Curves.elasticOut));
    _hookahFade = CurvedAnimation(
      parent: _hookahCtrl,
      curve: const Interval(0.0, 0.4, curve: Curves.easeIn),
    );

    // Glow flashes in fast then fades — Netflix punch effect
    _glowOpacity = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.0), weight: 25),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.0), weight: 75),
    ]).animate(CurvedAnimation(parent: _glowCtrl, curve: Curves.easeOut));

    _glowScale = Tween<double>(
      begin: 0.4,
      end: 2.2,
    ).animate(CurvedAnimation(parent: _glowCtrl, curve: Curves.easeOut));

    _titleFade = CurvedAnimation(parent: _titleCtrl, curve: Curves.easeIn);
    _titleSlide = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _titleCtrl, curve: Curves.easeOutCubic));

    _hookahCtrl.forward();
    _glowCtrl.forward();
    Future.delayed(const Duration(milliseconds: 550), () {
      if (mounted) _titleCtrl.forward();
    });
    Future.delayed(const Duration(milliseconds: 2300), _navigate);
  }

  @override
  void dispose() {
    _hookahCtrl.dispose();
    _glowCtrl.dispose();
    _titleCtrl.dispose();
    _smokeCtrl.dispose();
    _bubbleCtrl.dispose();
    super.dispose();
  }

  void _navigate() {
    if (mounted) context.go(Routes.ageGate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF120F0C),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 220,
              height: 320,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Amber glow — fades in then out on entrance
                  AnimatedBuilder(
                    animation: _glowCtrl,
                    builder: (_, _) => Opacity(
                      opacity: _glowOpacity.value,
                      child: Transform.scale(
                        scale: _glowScale.value,
                        child: Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: RadialGradient(
                              colors: [
                                AppColors.primary.withValues(alpha: 0.85),
                                AppColors.primary.withValues(alpha: 0.0),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Hookah with smoke + bubbles
                  ScaleTransition(
                    scale: _hookahScale,
                    child: FadeTransition(
                      opacity: _hookahFade,
                      child: AnimatedBuilder(
                        animation: Listenable.merge([_smokeCtrl, _bubbleCtrl]),
                        builder: (_, _) => CustomPaint(
                          size: const Size(180, 300),
                          painter: _HookahPainter(
                            smokeT: _smokeCtrl.value,
                            bubbleT: _bubbleCtrl.value,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            SlideTransition(
              position: _titleSlide,
              child: FadeTransition(
                opacity: _titleFade,
                child: Text(
                  context.l10n.appName,
                  style: context.textTheme.headlineMedium?.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HookahPainter extends CustomPainter {
  const _HookahPainter({required this.smokeT, required this.bubbleT});

  final double smokeT;
  final double bubbleT;

  static const _amber = Color(0xFFD4870A);
  static const _amberLight = Color(0xFFFFB740);
  static const _water = Color(0xFF1E3A5A);
  static const _bg = Color(0xFF2C2420);

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final h = size.height;
    final paint = Paint()..color = _amber;

    // — Base plate —
    final baseY = h - 14.0;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: Offset(cx, baseY), width: 88, height: 11),
        const Radius.circular(5),
      ),
      paint,
    );

    // — Stem —
    final stemTop = h * 0.535;
    final stemBot = baseY - 5;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTRB(cx - 6, stemTop, cx + 6, stemBot),
        const Radius.circular(3),
      ),
      paint,
    );

    // — Tray —
    canvas.drawOval(
      Rect.fromCenter(center: Offset(cx, stemTop - 1), width: 126, height: 13),
      paint,
    );

    // — Jar body —
    const jarRx = 56.0;
    const jarRy = 47.0;
    final jarCy = stemTop + 50;
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(cx, jarCy),
        width: jarRx * 2,
        height: jarRy * 2,
      ),
      paint,
    );

    // — Water fill (clipped to jar) —
    canvas.save();
    canvas.clipPath(
      Path()..addOval(
        Rect.fromCenter(
          center: Offset(cx, jarCy),
          width: jarRx * 2,
          height: jarRy * 2,
        ),
      ),
    );
    canvas.drawRect(
      Rect.fromLTWH(cx - jarRx, jarCy, jarRx * 2, jarRy),
      Paint()..color = _water,
    );
    canvas.restore();

    // — Jar gloss —
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(cx - 20, jarCy - 20),
        width: 30,
        height: 26,
      ),
      -2.4,
      1.1,
      false,
      Paint()
        ..color = _amberLight.withValues(alpha: 0.32)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4.5,
    );

    // — Bubbles (animated) —
    _drawBubbles(canvas, cx, jarCy, jarRx, jarRy);

    // — Bowl neck —
    final neckTop = h * 0.335;
    final neckPath = Path()
      ..moveTo(cx - 27, neckTop)
      ..lineTo(cx + 27, neckTop)
      ..lineTo(cx + 6, stemTop)
      ..lineTo(cx - 6, stemTop)
      ..close();
    canvas.drawPath(neckPath, paint);

    // — Bowl body —
    final bowlTop = h * 0.108;
    final bowlBot = neckTop;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTRB(cx - 35, bowlTop + 9, cx + 35, bowlBot),
        const Radius.circular(7),
      ),
      paint,
    );

    // — Bowl cap —
    canvas.drawOval(
      Rect.fromCenter(center: Offset(cx, bowlTop + 9), width: 72, height: 20),
      paint,
    );

    // — Bowl cap hole —
    canvas.drawOval(
      Rect.fromCenter(center: Offset(cx, bowlTop + 9), width: 30, height: 10),
      Paint()..color = _bg,
    );

    // — Bowl gloss —
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(cx - 12, bowlTop + 24),
        width: 16,
        height: 22,
      ),
      Paint()..color = _amberLight.withValues(alpha: 0.38),
    );

    // — Smoke wisps (animated) —
    _drawSmoke(canvas, cx, bowlTop + 2);
  }

  void _drawBubbles(
    Canvas canvas,
    double cx,
    double jarCy,
    double jarRx,
    double jarRy,
  ) {
    final paint = Paint()..style = PaintingStyle.fill;
    const specs = [
      (-22.0, 0.0, 3.2),
      (12.0, 0.28, 2.2),
      (-6.0, 0.55, 2.6),
      (26.0, 0.12, 1.8),
      (-32.0, 0.72, 2.0),
      (4.0, 0.42, 1.6),
    ];
    for (final (xOff, phase, r) in specs) {
      final t = (bubbleT + phase) % 1.0;
      final startY = jarCy + jarRy * 0.38;
      final endY = jarCy + 4;
      final y = startY + (endY - startY) * t;
      if (y < jarCy) continue;
      final x = cx + xOff + math.sin(t * math.pi * 3.5 + phase * 6.3) * 4.5;
      final opacity = math.sin(t * math.pi).clamp(0.0, 1.0) * 0.75;
      paint.color = const Color(0xFF7BC4FF).withValues(alpha: opacity);
      canvas.drawCircle(Offset(x, y), r, paint);
    }
  }

  void _drawSmoke(Canvas canvas, double cx, double topY) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.4
      ..strokeCap = StrokeCap.round;
    const wisps = [(-13.0, 0.0), (0.0, 0.34), (13.0, 0.67)];
    for (final (xOff, phase) in wisps) {
      final t = (smokeT + phase) % 1.0;
      final opacity = math.sin(t * math.pi).clamp(0.0, 1.0) * 0.6;
      paint.color = const Color(0xFFCCAA44).withValues(alpha: opacity);
      final path = Path();
      final sx = cx + xOff;
      final sy = topY - t * 52;
      path.moveTo(sx, sy);
      for (double dy = 0; dy < 36; dy += 2) {
        final wave =
            math.sin(t * math.pi * 4 + dy * 0.18 + phase * math.pi * 2) * 7;
        path.lineTo(sx + wave, sy - dy);
      }
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(_HookahPainter old) =>
      old.smokeT != smokeT || old.bubbleT != bubbleT;
}
