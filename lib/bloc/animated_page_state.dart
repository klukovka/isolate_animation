import 'package:equatable/equatable.dart';

class AnimatedPageState extends Equatable {
  final double angle;
  final double radius;
  final double side;
  final bool isAnimated;

  const AnimatedPageState({
    this.angle = 0,
    this.radius = 0,
    this.side = 100,
    this.isAnimated = true,
  });

  AnimatedPageState copyWith({
    double? angle,
    double? radius,
    double? side,
    bool? isAnimated,
  }) {
    return AnimatedPageState(
      angle: angle ?? this.angle,
      radius: radius ?? this.radius,
      side: side ?? this.side,
      isAnimated: isAnimated ?? this.isAnimated,
    );
  }

  @override
  List<Object> get props => [
        angle,
        radius,
        side,
        isAnimated,
      ];
}
