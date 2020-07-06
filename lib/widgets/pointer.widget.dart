import 'package:flutter/material.dart';

const _iconSize = 50.0;

class Pointer extends StatefulWidget {
  @override
  createState() => _PointerState();
}

class _PointerState extends State<Pointer> with SingleTickerProviderStateMixin {
  AnimationController _jumpController;
  Animation<Offset> _tween;

  @override
  void initState() {
    super.initState();
    _jumpController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _tween = Tween(begin: Offset(0, 0), end: Offset(0, -15)).animate(
        CurvedAnimation(parent: _jumpController, curve: Curves.easeInOut));

    // 执行跳动动画
    _jumpController.forward().then((it) => _jumpController.reverse());
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: AnimatedBuilder(
            animation: _tween,
            builder: (context, child) {
              return Transform.translate(
                  offset:
                      Offset(_tween.value.dx, _tween.value.dy - _iconSize / 2),
                  child: child);
            },
            child: Image.asset(
              'images/wechat_locate.png',
              height: _iconSize,
            )));
  }
}
