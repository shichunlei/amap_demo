import 'package:amap_demo/utils/utils.export.dart';
import 'package:amap_location_fluttify/amap_location_fluttify.dart';
import 'package:flutter/material.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({Key key}) : super(key: key);

  @override
  createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen>
    with AmapLocationDisposeMixin {
  Location _location;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(title: Text('定位')),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              RaisedButton(
                  child: Text('获取单次定位'),
                  onPressed: () async {
                    if (await requestPermission()) {
                      final location = await AmapLocation.fetchLocation(
                          mode: LocationAccuracy.High);
                      setState(() => _location = location);
                    }
                  }),
              RaisedButton(
                  child: Text('获取连续定位'),
                  onPressed: () async {
                    if (await requestPermission()) {
                      await for (final location
                          in AmapLocation.listenLocation()) {
                        setState(() => _location = location);
                      }
                    }
                  }),
              RaisedButton(
                  child: Text('停止定位'),
                  onPressed: () async {
                    if (await requestPermission()) {
                      await AmapLocation.stopLocation();
//                setState(() => _location = null);
                    }
                  }),
              Center(
                  child: Text(
                      _location == null
                          ? ""
                          : "地址 => ${_location.address}\n纬度 => ${_location.latLng.latitude}\n经度 => ${_location.latLng.longitude}\n海拔 => ${_location.altitude}\nbearing => ${_location.bearing}\n国家 => ${_location.country}\n省份 => ${_location.province}\n城市 => ${_location.city}\n城市编码 => ${_location.cityCode}\nadCode => ${_location.adCode}\n区县 => ${_location.district}\n街道 => ${_location.street}\n街道号码 => ${_location.streetNumber}\naoiName => ${_location.aoiName}\n精度 => ${_location.accuracy}",
                      textAlign: TextAlign.center))
            ]));
  }
}
