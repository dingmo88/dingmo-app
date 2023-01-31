import 'package:flutter/material.dart';

class FadeButton extends StatefulWidget {
  const FadeButton({Key? key}) : super(key: key);

  @override
  State<FadeButton> createState() => _FadeButtonState();
}

class _FadeButtonState extends State<FadeButton> {
  bool _visible = false;
  bool _fadeIn = false;

  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: _visible,
        child: AnimatedOpacity(
          opacity: _fadeIn ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 400),
          child: Container(
            width: 200.0,
            height: 200.0,
            color: Colors.green,
          ),
        ));
  }

  void fadeInAnOut() {
    setState(() {
      _visible = !_visible;
    });
    setState(() {
      _fadeIn = !_fadeIn;
    });
    Future.delayed(const Duration(milliseconds: 10), () {
      setState(() {
        _fadeIn = !_fadeIn;
        _visible = !_visible;
      });
    });
  }
}
