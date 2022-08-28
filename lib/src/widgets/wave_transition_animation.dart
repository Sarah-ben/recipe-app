import 'package:flutter/material.dart';

class WaveTransitionAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final FractionalOffset waveStart;
  const WaveTransitionAnimation(
      {Key? key,
      required this.child,
      required this.duration,
      required this.waveStart})
      : super(key: key);

  @override
  State<WaveTransitionAnimation> createState() =>
      WaveTransitionAnimationState();
}

class WaveTransitionAnimationState extends State<WaveTransitionAnimation>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(vsync: this, duration: widget.duration);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(controller);
    controller.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        child: AnimatedBuilder(
          animation: controller,
          child: widget.child,
          builder: (context, child) {
            return ShaderMask(
              shaderCallback: (rect) {
                return RadialGradient(
                  radius: (animation.value as double) * 5,
                  colors: [
                    Colors.white,
                    Colors.white,
                    Colors.transparent,
                    Colors.transparent
                  ],
                  stops: [0, 0.55, 0.6, 1],
                  center: widget.waveStart,
                ).createShader(rect);
              },
              child: child,
            );
          },
        ),
      ),
    );
  }
}
