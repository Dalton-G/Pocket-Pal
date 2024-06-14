import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ConfettiAnimation extends StatelessWidget {
  final AnimationController controller;

  const ConfettiAnimation({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        'lib/src/assets/animations/confettiLottie.json',
        repeat: false,
        controller: controller,
        frameRate: FrameRate.max,
      ),
    );
  }
}
