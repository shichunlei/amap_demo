import 'dart:typed_data';

import 'package:amap_map_fluttify/amap_map_fluttify.dart';
import 'package:flutter/material.dart';

class ScreenShotScreen extends StatefulWidget {
  @override
  createState() => _ScreenShotScreenState();
}

class _ScreenShotScreenState extends State<ScreenShotScreen> {
  Uint8List _data;
  AmapController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('截图')),
      body: Column(
        children: <Widget>[
          Flexible(
            flex: 2,
            child: AmapView(
              maskDelay: Duration(milliseconds: 500),
              onMapCreated: (controller) async {
                _controller = controller;
              },
            ),
          ),
          Flexible(
            flex: 3,
            child: ListView(
              children: <Widget>[
                RaisedButton(
                  onPressed: () async {
                    _controller.screenShot((data) async {
                      setState(() {
                        _data = data;
                      });
                    });
                  },
                  child: Text('截图'),
                ),
                if (_data != null) Image.memory(_data)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
