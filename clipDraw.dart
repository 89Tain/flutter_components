import 'package:flutter/material.dart';
import 'dart:math' as math;

class XAnimationClip extends StatefulWidget {
  const XAnimationClip({super.key});

  @override
  State<XAnimationClip> createState() => _XAnimationClipState();
}

class _XAnimationClipState extends State<XAnimationClip>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      value: 0.0,
      duration: const Duration(seconds: 25),
      upperBound: 1,
      lowerBound: -1,
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose(); // Dispose of the animation controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        // animation
        AnimatedBuilder(
          animation: _animationController,
          child: Container(
            height: size.height * 0.45,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [theme.primaryColor, theme.colorScheme.secondary],
              ),
            ),
          ),
          builder: (BuildContext context, Widget? child) {
            return ClipPath(
              clipper: TDrawClip(_animationController.value),
              child: child,
            );
          },
        ),
        Container(
          padding: const EdgeInsets.only(bottom: 60),
          child: const Text(
            "Road Track",
            style: TextStyle(
              color: Colors.white,
              fontSize: 46,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const Text(
          "Keep track of your driving",
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}

class TDrawClip extends CustomClipper<Path> {
  double move = 0;
  double slice = math.pi;
  TDrawClip(this.move);

  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height * 0.8);
    double xCenter =
        size.width * 0.5 + (size.width * 0.6 + 1) * math.sin(move * slice);
    double yCenter = size.height * 0.8 + 69 * math.cos(move * slice);

    path.quadraticBezierTo(xCenter, yCenter, size.width, size.height * 0.8);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
