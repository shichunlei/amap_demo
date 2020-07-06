import 'dart:async';

import 'package:amap_map_fluttify/amap_map_fluttify.dart';
import 'package:amap_search_fluttify/amap_search_fluttify.dart';
import 'package:flutter/material.dart';

import '../bean/poi.dart';
import '../utils/misc.dart';
import '../widgets/item_pois.dart';

final _assetsIcon = Uri.parse('images/wechat_locate.png');

class LocationPicker extends StatefulWidget {
  LocationPicker({Key key}) : super(key: key);

  @override
  createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
  AmapController _controller;

  List<PoiBean> _poiTitleList = [];

  List<Marker> _markers = [];

  LatLng location;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(title: Text('选择位置'), actions: <Widget>[
          IconButton(
              icon: Icon(Icons.edit_location),
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (_) {
                      return Container(
                          child: ListView.builder(
                              itemBuilder: (_, index) =>
                                  ItemPoiView(poi: _poiTitleList[index]),
                              itemCount: _poiTitleList.length));
                    });
              })
        ]),
        body: AmapView(

            /// 地图类型
            mapType: MapType.Standard,

            /// 显示缩放控件
            showZoomControl: false,

            /// 显示指南针
            showCompass: true,

            /// 显示比例尺
            showScaleControl: true,
            maskDelay: Duration(milliseconds: 500),
            onMapCreated: (controller) async {
              _controller = controller;

              if (await requestPermission()) {
                await _controller.showMyLocation(MyLocationOption(show: true));

                await _controller.setZoomLevel(18, animated: false);

                /// 显示路况
                await _controller?.showTraffic(true);

                /// 显示定位按钮
                await _controller?.showLocateControl(true);

                Future.delayed(Duration(milliseconds: 100), () async {
                  location = await _controller.getLocation();

                  print(
                      '=======================: lat: ${location.latitude}, lng: ${location.longitude}');
                });
              }
            },

            /// 开始移动
            onMapMoveStart: (MapMove move) async {
              print('开始移动: $move');
            },

            /// 移动结束
            onMapMoveEnd: (MapMove move) async {
              print(
                  '结束移动:lat: ${move.latLng.latitude}, lng: ${move.latLng.longitude}');

              if (_markers.length == 0) {
                final marker = await _controller?.addMarker(MarkerOption(
                    latLng: move.latLng,
                    title: '北京',
                    snippet: '描述',
                    iconUri: _assetsIcon,
                    imageConfig: createLocalImageConfiguration(context),
                    width: 48,
                    height: 48,
                    object: '自定义数据'));

                _markers.add(marker);
              } else {
                await _markers?.first?.setCoordinate(move.latLng);
              }

              _poiTitleList = await getPoiData(latLng: move.latLng);

              setState(() {});
            }));
  }
}
