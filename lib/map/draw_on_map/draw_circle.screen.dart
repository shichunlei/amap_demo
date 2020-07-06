import 'package:amap_demo/utils/utils.export.dart';
import 'package:amap_map_fluttify/amap_map_fluttify.dart';
import 'package:flutter/material.dart';

class DrawCircleScreen extends StatefulWidget {
  DrawCircleScreen();

  factory DrawCircleScreen.forDesignTime() => DrawCircleScreen();

  @override
  createState() => _DrawCircleScreenState();
}

class _DrawCircleScreenState extends State<DrawCircleScreen> with NextLatLng {
  AmapController _controller;
  List<Circle> _circleList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('绘制圆')),
      body: Column(
        children: <Widget>[
          Flexible(
            flex: 1,
            child: AmapView(
              onMapCreated: (controller) async {
                _controller = controller;
              },
            ),
          ),
          Flexible(
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Center(child: Text('添加圆')),
                  onTap: () async {
                    final circle = await _controller?.addCircle(CircleOption(
                      center: LatLng(39.999391, 116.135972),
                      radius: 10000,
                      width: 10,
                      strokeColor: Colors.green,
                    ));
                    _circleList.add(circle);
                  },
                ),
                ListTile(
                  title: Center(child: Text('删除圆')),
                  onTap: () async {
                    if (_circleList.isNotEmpty) {
                      await _circleList.first.remove();
                      _circleList.removeAt(0);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
