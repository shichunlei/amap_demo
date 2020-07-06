import 'package:amap_demo/widgets/setting.widget.dart';
import 'package:amap_map_fluttify/amap_map_fluttify.dart';
import 'package:flutter/material.dart';

class CodeInteractionScreen extends StatefulWidget {
  CodeInteractionScreen();

  factory CodeInteractionScreen.forDesignTime() => CodeInteractionScreen();

  @override
  createState() => _CodeInteractionScreenState();
}

class _CodeInteractionScreenState extends State<CodeInteractionScreen> {
  AmapController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('调用方法交互')),
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
            child: ListView(
              children: <Widget>[
                ContinuousSetting(
                  head: '缩放大小',
                  min: 0,
                  max: 20,
                  onChanged: (value) {
                    _controller?.setZoomLevel(value);
                  },
                ),
                DiscreteSetting(
                  head: '放大/缩小一个等级',
                  options: ['放大', '缩小'],
                  onSelected: (value) {
                    switch (value) {
                      case '放大':
                        _controller?.zoomIn();
                        break;
                      case '缩小':
                        _controller?.zoomOut();
                        break;
                    }
                  },
                ),
                DiscreteSetting(
                  head: '设置地图中心点',
                  options: ['广州', '北京', '上海'],
                  onSelected: (value) {
                    switch (value) {
                      case '广州':
                        _controller?.setCenterCoordinate(
                          23.16,
                          113.23,
                          animated: false,
                        );
                        break;
                      case '北京':
                        _controller?.setCenterCoordinate(
                          39.90960,
                          116.397228,
                          animated: true,
                        );
                        break;
                      case '上海':
                        _controller?.setCenterCoordinate(31.22, 121.48);
                        break;
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
