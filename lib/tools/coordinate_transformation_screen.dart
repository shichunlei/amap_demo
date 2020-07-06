import 'package:amap_map_fluttify/amap_map_fluttify.dart';
import 'package:flutter/material.dart';

class CoordinateTransformationScreen extends StatefulWidget {
  @override
  createState() => _CoordinateTransformationStateScreen();
}

class _CoordinateTransformationStateScreen
    extends State<CoordinateTransformationScreen> {
  final _latController = TextEditingController(text: "39.914266");
  final _lngController = TextEditingController(text: "116.403988");

  final _coord = LatLng(39.914266, 116.403988);
  LatLng _target = LatLng(39.914266, 116.403988);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('坐标转换')),
      body: Column(
        children: <Widget>[
          TextFormField(
            readOnly: true,
            controller: _latController,
            decoration: InputDecoration(
              labelText: "纬度 latitude",
              border: OutlineInputBorder(),
            ),
            enabled: false,
          ),
          TextFormField(
            readOnly: true,
            controller: _lngController,
            decoration: InputDecoration(
              labelText: "经度 longitude",
              border: OutlineInputBorder(),
            ),
            enabled: false,
          ),
          Text('转换结果: $_target'),
          Expanded(
            child: ListView(
              children: <Widget>[
                RaisedButton(
                  onPressed: () async {
                    final result =
                        await AmapService.convertCoord(_coord, CoordType.GPS);
                    setState(() {
                      _target = result;
                    });
                  },
                  child: Text('GPS'),
                ),
                RaisedButton(
                  onPressed: () async {
                    final result = await AmapService.convertCoord(
                        _coord, CoordType.Google);
                    setState(() {
                      _target = result;
                    });
                  },
                  child: Text('Google'),
                ),
                RaisedButton(
                  onPressed: () async {
                    final result = await AmapService.convertCoord(
                        _coord, CoordType.MapBar);
                    setState(() {
                      _target = result;
                    });
                  },
                  child: Text('MapBar'),
                ),
                RaisedButton(
                  onPressed: () async {
                    final result =
                        await AmapService.convertCoord(_coord, CoordType.Baidu);
                    setState(() {
                      _target = result;
                    });
                  },
                  child: Text('Baidu'),
                ),
                RaisedButton(
                  onPressed: () async {
                    final result = await AmapService.convertCoord(
                        _coord, CoordType.MapABC);
                    setState(() {
                      _target = result;
                    });
                  },
                  child: Text('MapABC'),
                ),
                RaisedButton(
                  onPressed: () async {
                    final result = await AmapService.convertCoord(
                        _coord, CoordType.SosoMap);
                    setState(() {
                      _target = result;
                    });
                  },
                  child: Text('SosoMap'),
                ),
                RaisedButton(
                  onPressed: () async {
                    final result = await AmapService.convertCoord(
                        _coord, CoordType.Aliyun);
                    setState(() {
                      _target = result;
                    });
                  },
                  child: Text('Aliyun'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
