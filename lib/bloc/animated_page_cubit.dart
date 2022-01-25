import 'dart:async';
import 'dart:isolate';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isolate_animation/bloc/animated_page_state.dart';
import 'package:isolate_animation/bloc/animation_dto.dart';

class AnimatedPageCubit extends Cubit<AnimatedPageState> {
  late ReceivePort _receivePortAnimation;
  late Isolate _isolateAnimation;
  late Capability _capabilityAnimation;

  late ReceivePort _receivePortColor;
  late Isolate _isolateColor;

  AnimatedPageCubit() : super(const AnimatedPageState()) {
    init();
  }

  void init() async {
    _receivePortAnimation = ReceivePort();
    _isolateAnimation = await Isolate.spawn(
        _animate,
        AnimationDto(
          sendPort: _receivePortAnimation.sendPort,
          angle: state.angle,
          radius: state.radius,
          side: state.side,
        ));
    _receivePortAnimation.listen(_listenAnimation);
  }

  void changeColor() async {
    _receivePortColor = ReceivePort();
    _isolateColor = await Isolate.spawn(
      _changeColor,
      _receivePortColor.sendPort,
    );
    _receivePortColor.listen(_listenColor);
  }

  void enableAnimation() {
    emit(state.copyWith(isAnimated: true));
    _isolateAnimation.resume(_capabilityAnimation);
  }

  void disableAnimation() {
    emit(state.copyWith(isAnimated: false));
    _capabilityAnimation = _isolateAnimation.pause();
  }

  void _listenAnimation(dynamic animationDto) {
    emit(state.copyWith(
      angle: animationDto.angle,
      radius: animationDto.radius,
      side: animationDto.side,
    ));
  }

  void _listenColor(dynamic color) {
    emit(state.copyWith(color: color));
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

  static void _changeColor(SendPort sendPort) {
    final random = Random();
    final color = Color.fromRGBO(
      random.nextInt(255),
      random.nextInt(255),
      random.nextInt(255),
      1,
    );
    sendPort.send(color);
  }

  void dispose() {
    _receivePortAnimation.close();
    _isolateAnimation.kill(priority: Isolate.immediate);
    _receivePortColor.close();
    _isolateColor.kill(priority: Isolate.immediate);
  }
}
