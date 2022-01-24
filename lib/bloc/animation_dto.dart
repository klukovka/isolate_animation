import 'dart:isolate';

import 'package:equatable/equatable.dart';

class AnimationDto extends Equatable {
  final SendPort sendPort;
  final double angle;
  final double radius;
  final double side;

  const AnimationDto({
    required this.angle,
    required this.sendPort,
    required this.radius,
    required this.side,
  });

  @override
  List<Object> get props => [sendPort, angle, radius, side];
}
