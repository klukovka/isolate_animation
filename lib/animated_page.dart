import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isolate_animation/animated_rect.dart';
import 'package:isolate_animation/bloc/animated_page_cubit.dart';
import 'package:isolate_animation/bloc/animated_page_state.dart';

class AnimatedPage extends StatefulWidget {
  const AnimatedPage({Key? key}) : super(key: key);

  @override
  State<AnimatedPage> createState() => _AnimatedPageState();
}

class _AnimatedPageState extends State<AnimatedPage> {
  AnimatedPageCubit get cubit => context.read<AnimatedPageCubit>();

  @override
  void dispose() {
    cubit.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AnimatedPageCubit, AnimatedPageState>(
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

  TextButton _buildProceedButton(AnimatedPageState state) {
    return TextButton(
      onPressed:
          state.isAnimated ? cubit.disableAnimation : cubit.enableAnimation,
      child: Text(
        state.isAnimated ? 'STOP' : 'START',
      ),
    );
  }

  Widget _buildAnimatedRect(AnimatedPageState state) {
    return AnimatedRect(
      angle: state.angle,
      side: state.side,
      radius: state.radius,
    );
  }
}
