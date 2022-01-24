import 'dart:async';
import 'dart:isolate';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isolate_animation/bloc/rect_state.dart';
import 'package:isolate_animation/bloc/animation_dto.dart';

class RectCubit extends Cubit<RectState> {
  late ReceivePort _receivePort;
  late Isolate _isolate;
  late Capability _capability;

  RectCubit() : super(const RectState()) {
    init();
  }

  void init() async {
    _receivePort = ReceivePort();
    _isolate = await Isolate.spawn(
        _animate,
        AnimationDto(
          sendPort: _receivePort.sendPort,
          angle: state.angle,
          radius: state.radius,
          side: state.side,
        ));
    _receivePort.listen(_listenAngle);
  }

  void enableAnimation() {
    emit(state.copyWith(isAnimated: true));
    _isolate.resume(_capability);
  }

  void disableAnimation() {
    emit(state.copyWith(isAnimated: false));
    _capability = _isolate.pause();
  }

  void _listenAngle(dynamic animationDto) {
    emit(state.copyWith(
      angle: animationDto.angle,
      radius: animationDto.radius,
      side: animationDto.side,
    ));
  }

  static void _animate(AnimationDto dto) {
    final sendPort = dto.sendPort;
    var angle = dto.angle;
    var side = dto.side;
    var radius = dto.radius;

    var isSideGrowing = true;
    var isRadiusGrowing = true;

    Timer.periodic(
      const Duration(milliseconds: 20),
      (_) {
        if (side > 300) {
          isSideGrowing = false;
        } else if (side < 100) {
          isSideGrowing = true;
        }

        if (isSideGrowing) {
          side++;
        } else {
          side--;
        }

        if (radius > 100) {
          isRadiusGrowing = false;
        } else if (radius < 1) {
          isRadiusGrowing = true;
        }

        if (isRadiusGrowing) {
          radius++;
        } else {
          radius--;
        }

        angle += 0.01;
        sendPort.send(AnimationDto(
          angle: angle,
          sendPort: sendPort,
          radius: radius,
          side: side,
        ));
      },
    );
  }

  void dispose() {
    _receivePort.close();
    _isolate.kill(priority: Isolate.immediate);
  }
}
