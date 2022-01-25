import 'package:flutter/material.dart';

class AnimatedRect extends StatelessWidget {
  final double angle;
  final double side;
  final double radius;

  const AnimatedRect({
    Key? key,
    required this.angle,
    required this.radius,
    required this.side,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: angle,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 20),
        width: side,
        height: side,
        decoration: BoxDecoration(
          color: Colors.deepPurpleAccent,
          borderRadius: BorderRadius.all(
            Radius.circular(radius),
          ),
        ),
      ),
    );
  }
}
