import 'package:equatable/equatable.dart';

class RectState extends Equatable {
  final double angle;
  final double radius;
  final double side;
  final bool isAnimated;

  const RectState({
    this.angle = 0,
    this.radius = 0,
    this.side = 100,
    this.isAnimated = true,
  });

  RectState copyWith({
    double? angle,
    double? radius,
    double? side,
    bool? isAnimated,
  }) {
    return RectState(
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
