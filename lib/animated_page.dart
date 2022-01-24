import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isolate_animation/animated_rect.dart';
import 'package:isolate_animation/bloc/rect_cubit.dart';
import 'package:isolate_animation/bloc/rect_state.dart';

class AnimatedPage extends StatefulWidget {
  const AnimatedPage({Key? key}) : super(key: key);

  @override
  State<AnimatedPage> createState() => _AnimatedPageState();
}

class _AnimatedPageState extends State<AnimatedPage> {
  RectCubit get cubit => context.read<RectCubit>();

  @override
  void dispose() {
    cubit.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<RectCubit, RectState>(
        builder: (
          context,
          state,
        ) {
          return Stack(
            children: [
              Center(child: _buildAnimatedRect(state)),
              Align(
                alignment: Alignment.bottomCenter,
                child: _buildProceedButton(state),
              ),
            ],
          );
        },
      ),
    );
  }

  TextButton _buildProceedButton(RectState state) {
    return TextButton(
      onPressed:
          state.isAnimated ? cubit.disableAnimation : cubit.enableAnimation,
      child: Text(
        state.isAnimated ? 'STOP' : 'START',
      ),
    );
  }

  Widget _buildAnimatedRect(RectState state) {
    return AnimatedRect(
      angle: state.angle,
      side: state.side,
      radius: state.radius,
    );
  }
}
