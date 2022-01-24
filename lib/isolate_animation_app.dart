import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isolate_animation/animated_page.dart';
import 'package:isolate_animation/bloc/rect_cubit.dart';

class IsolateAnimationApp extends StatelessWidget {
  const IsolateAnimationApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (_) => RectCubit(),
        child: const AnimatedPage(),
      ),
    );
  }
}
