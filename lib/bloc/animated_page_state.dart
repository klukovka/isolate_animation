import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class AnimatedPageState extends Equatable {
  final double angle;
  final double radius;
  final double side;
  final bool isAnimated;
  final Color color;

  const AnimatedPageState({
    this.angle = 0,
    this.radius = 0,
    this.side = 100,
    this.isAnimated = true,
    this.color = Colors.deepPurple,
  });

  AnimatedPageState copyWith({
    double? angle,
    double? radius,
    double? side,
    bool? isAnimated,
    Color? color,
  }) {
    return AnimatedPageState(
      angle: angle ?? this.angle,
      radius: radius ?? this.radius,
      side: side ?? this.side,
      isAnimated: isAnimated ?? this.isAnimated,
      color: color ?? this.color,
    );
  }

  @override
  List<Object> get props {
    return [
      angle,
      radius,
      side,
      isAnimated,
      color,
    ];
  }
}
