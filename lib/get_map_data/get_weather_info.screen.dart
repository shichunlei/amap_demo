import 'package:amap_search_fluttify/amap_search_fluttify.dart';
import 'package:flutter/material.dart';

/// 获取天气数据
class GetWeatherInfoScreen extends StatefulWidget {
  @override
  _GetWeatherInfoScreenState createState() => _GetWeatherInfoScreenState();
}

class _GetWeatherInfoScreenState extends State<GetWeatherInfoScreen>
    with AmapSearchDisposeMixin {
  final _keywordController = TextEditingController(text: '杭州');

  String _district = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(title: Text('获取天气数据')),
      body: Column(
        children: <Widget>[
          TextFormField(
            controller: _keywordController,
            decoration: InputDecoration(hintText: '输入地区'),
          ),
          RaisedButton(
            onPressed: () async {
              final district =
                  await AmapSearch.searchDistrict(_keywordController.text);
              _district = await district.toFutureString();
              setState(() {});
            },
            child: Text('搜索'),
          ),
          Expanded(child: SingleChildScrollView(child: Text(_district))),
        ],
      ),
    );
  }
}
