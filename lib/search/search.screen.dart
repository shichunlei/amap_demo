import 'package:amap_all_fluttify/amap_all_fluttify.dart';
import 'package:flutter/material.dart';

class ShowSearchResultScreen extends StatefulWidget {
  @override
  createState() => _ShowSearchResultScreenState();
}

class _ShowSearchResultScreenState extends State<ShowSearchResultScreen> {
  AmapController _controller;

  final _fromLatitudeController = TextEditingController(text: '39.90896');
  final _fromLongitudeController = TextEditingController(text: '116.396053');

  final _toLatitudeController = TextEditingController(text: '39.8705');
  final _toLongitudeController = TextEditingController(text: '116.445491');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('显示路线规划结果')),
        body: Column(children: <Widget>[
          Expanded(child: AmapView(onMapCreated: (controller) async {
            _controller = controller;
          })),
          Column(children: <Widget>[
            Row(children: <Widget>[
              Text('点1:'),
              Flexible(
                  child: TextFormField(
                      controller: _fromLatitudeController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(hintText: '输入点1纬度'))),
              Flexible(
                  child: TextFormField(
                      controller: _fromLongitudeController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(hintText: '输入点1经度')))
            ]),
            Row(children: <Widget>[
              Text('点2:'),
              Flexible(
                  child: TextFormField(
                      controller: _toLatitudeController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(hintText: '输入点2纬度'))),
              Flexible(
                  child: TextFormField(
                      controller: _toLongitudeController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(hintText: '输入点2经度')))
            ]),
            RaisedButton(onPressed: _handleSearchRoute, child: Text('计算'))
          ])
        ]));
  }

  Future<void> _handleSearchRoute() async {
    final fromLat = double.tryParse(_fromLatitudeController.text);
    final fromLng = double.tryParse(_fromLongitudeController.text);
    final toLat = double.tryParse(_toLatitudeController.text);
    final toLng = double.tryParse(_toLongitudeController.text);

    try {
      final route = await AmapSearch.searchDriveRoute(
          from: LatLng(fromLat, fromLng), to: LatLng(toLat, toLng));
      _controller.addDriveRoute(route,
          trafficOption: TrafficOption(show: true));
    } catch (e) {
      print(e.toString());
    }
  }
}
