import 'package:flutter/material.dart'
    '';

class AnimatedProgressIOndicator extends StatefulWidget {
  final double value;

  const AnimatedProgressIOndicator({Key? key, required this.value})
      : super(key: key);

  @override
  _AnimatedProgressIOndicatorState createState() =>
      _AnimatedProgressIOndicatorState();
}

class _AnimatedProgressIOndicatorState extends State<AnimatedProgressIOndicator>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  late Animation<Color?> _colorAnimation;
  late Animation<double> _curveAnimation;

  @override
  void initState() {

    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1200));

    final colorTween = TweenSequence([
      TweenSequenceItem(
        tween: ColorTween(begin: Colors.red, end: Colors.orange),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: ColorTween(begin: Colors.orange, end: Colors.yellow),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: ColorTween(begin: Colors.yellow, end: Colors.green),
        weight: 1,
      ),
    ]);

    _colorAnimation = _controller!.drive(colorTween);
    _curveAnimation = _controller!.drive(CurveTween(curve: Curves.easeIn));

    super.initState();
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
    _controller!.animateTo(widget.value);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: (BuildContext context, Widget? child) => LinearProgressIndicator(
        value: _curveAnimation.value,
        valueColor: _colorAnimation,
        backgroundColor: _colorAnimation.value?.withOpacity(0.4),
      ),
      animation: _controller!,
    );
  }
}
