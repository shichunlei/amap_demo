import 'package:amap_map_fluttify/amap_map_fluttify.dart';
import 'package:flutter/material.dart';

import 'get_map_data/get_address_desc.screen.dart';
import 'get_map_data/get_bus_info.screen.dart';
import 'get_map_data/get_district_info.screen.dart';
import 'get_map_data/get_poi.screen.dart';
import 'get_map_data/get_weather_info.screen.dart';
import 'interact_with_map/code_interaction.screen.dart';
import 'interact_with_map/control_interaction.screen.dart';
import 'interact_with_map/gesture_interaction.screen.dart';
import 'interact_with_map/screen_shot_screen.dart';
import 'location/location.screen.dart';
import 'map/create_map.screen.dart';
import 'map/draw_on_map/draw_circle.screen.dart';
import 'map/draw_on_map/draw_point.screen.dart';
import 'map/draw_on_map/draw_polygon.screen.dart';
import 'map/draw_on_map/draw_polyline.screen.dart';
import 'map/multi_map.screen.dart';
import 'route_plan/route_bus.screen.dart';
import 'route_plan/route_drive.screen.dart';
import 'route_plan/route_ride.screen.dart';
import 'route_plan/route_walk.screen.dart';
import 'search/location_picker.dart';
import 'search/search.screen.dart';
import 'search/search_location.screen.dart';
import 'tools/calcute_distance_screen.dart';
import 'tools/coordinate_transformation_screen.dart';
import 'tools/launch_amap_screen.dart';
import 'tools/offline_manager_screen.dart';
import 'tools/processed_trace.screen.dart';
import 'widgets/function_group.widget.dart';
import 'widgets/function_item.widget.dart';
import 'widgets/todo.screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AmapService.init(
    iosKey: 'f583e0d5b70400167993615c3adc3ced',
    androidKey: '13125a05b3110bab19d913adfa2df8b5',
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Home());
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('AMaps examples')),
        body: ListView(children: <Widget>[
          FunctionGroup(headLabel: '获取地图数据', children: <Widget>[
            FunctionItem(
                label: '获取POI数据',
                sublabel: 'GetPoiScreen',
                target: GetPoiScreen()),
            FunctionItem(
                label: '获取地址描述数据',
                sublabel: 'GetAddressDescScreen',
                target: GetAddressDescScreen()),
            FunctionItem(
                label: '获取行政区划数据',
                sublabel: 'GetDistrictInfoScreen',
                target: GetDistrictInfoScreen()),
            FunctionItem(
                label: '获取公交数据',
                sublabel: 'GetBusInfoScreenScreen',
                target: GetBusInfoScreen()),
            FunctionItem(
                label: '后获取天气数据',
                sublabel: 'GetWeatherInfoScreen',
                target: GetWeatherInfoScreen()),
            FunctionItem(
                label: '获取业务数据(云图功能)', sublabel: 'TODO', target: TodoScreen()),
            FunctionItem(
                label: '获取交通态势信息', sublabel: 'TODO', target: TodoScreen())
          ]),
          FunctionGroup(headLabel: '出行路线规划', children: <Widget>[
            FunctionItem(
                label: '驾车出行路线规划',
                sublabel: 'RouteDriveScreen',
                target: RouteDriveScreen()),
            FunctionItem(
                label: '步行出行路线规划',
                sublabel: 'RouteWalkScreen',
                target: RouteWalkScreen()),
            FunctionItem(
                label: '公交出行路线规划',
                sublabel: 'RouteBusScreen',
                target: RouteBusScreen()),
            FunctionItem(
                label: '骑行出行路线规划',
                sublabel: 'RouteRideScreen',
                target: RouteRideScreen()),
            FunctionItem(
                label: '货车出行路线规划', sublabel: 'TODO', target: TodoScreen()),
            FunctionItem(
                label: '未来出行路线规划', sublabel: 'TODO', target: TodoScreen())
          ]),
          FunctionGroup(headLabel: '定位', children: <Widget>[
            FunctionItem(
                label: '定位',
                sublabel: 'LocationScreen',
                target: LocationScreen())
          ]),
          FunctionGroup(headLabel: '创建地图', children: <Widget>[
            FunctionItem(
                label: '显示地图',
                sublabel: 'CreateMapScreen',
                target: CreateMapScreen()),
            FunctionItem(
                label: '显示多地图',
                sublabel: 'MultiMapScreen',
                target: MultiMapScreen()),
          ]),
          FunctionGroup(headLabel: '在地图上绘制', children: <Widget>[
            FunctionItem(
                label: '绘制点标记',
                sublabel: 'DrawPointScreen',
                target: DrawPointScreen()),
            FunctionItem(
                label: '绘制线',
                sublabel: 'DrawPolylineScreen',
                target: DrawPolylineScreen()),
            FunctionItem(
                label: '绘制圆',
                sublabel: 'DrawCircleScreen',
                target: DrawCircleScreen()),
            FunctionItem(
                label: '绘制多边形',
                sublabel: 'DrawPolygonScreen',
                target: DrawPolygonScreen())
          ]),
          FunctionGroup(headLabel: '与地图交互', children: <Widget>[
            FunctionItem(
                label: '控件交互',
                sublabel: 'ControlInteractionScreen',
                target: ControlInteractionScreen()),
            FunctionItem(
                label: '手势交互',
                sublabel: 'GestureInteractionScreen',
                target: GestureInteractionScreen()),
            FunctionItem(
                label: '调用方法交互',
                sublabel: 'CodeInteractionScreen',
                target: CodeInteractionScreen()),
            FunctionItem(
                label: '截图',
                sublabel: 'ScreenShotScreen',
                target: ScreenShotScreen())
          ]),
          FunctionGroup(headLabel: "工具", children: <Widget>[
            FunctionItem(
                label: "坐标转换",
                sublabel: "CoordinateTransformationScreen",
                target: CoordinateTransformationScreen()),
            FunctionItem(
                label: "两点间距离计算",
                sublabel: "CalculateDistanceScreen",
                target: CalculateDistanceScreen()),
            FunctionItem(
                label: "调用高德地图",
                sublabel: "LaunchAmapScreen",
                target: LaunchAmapScreen()),
            FunctionItem(
                label: "轨迹纠偏",
                sublabel: "ProcessedTraceScreen",
                target: ProcessedTraceScreen()),
            FunctionItem(
                label: "离线地图",
                sublabel: "OfflineManagerScreen",
                target: OfflineManagerScreen())
          ]),
          FunctionGroup(headLabel: '地址选择', children: <Widget>[
            FunctionItem(
                label: '地址选择',
                sublabel: 'LocationPicker',
                target: LocationPicker()),
            FunctionItem(
                label: '地址选择',
                sublabel: 'ShowSearchResultScreen',
                target: ShowSearchResultScreen()),
            FunctionItem(
                label: '地址选择',
                sublabel: 'SearchLocationScreen',
                target: SearchLocationScreen())
          ]),
        ]));
  }
}
