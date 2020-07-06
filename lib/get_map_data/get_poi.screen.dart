import 'package:amap_demo/widgets/function_item.widget.dart';
import 'package:amap_demo/widgets/scrollable_text.widget.dart';
import 'package:amap_search_fluttify/amap_search_fluttify.dart';
import 'package:flutter/material.dart';

class GetPoiScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(title: Text('获取POI数据')),
      body: ListView(
        children: <Widget>[
          FunctionItem(
            label: '关键字检索POI',
            sublabel: 'KeywordPoiScreen',
            target: KeywordPoiScreen(),
          ),
          FunctionItem(
            label: '周边检索POI',
            sublabel: 'AroundPoiScreen',
            target: AroundPoiScreen(),
          ),
          FunctionItem(
            label: '输入提示',
            sublabel: 'InputTipScreen',
            target: InputTipScreen(),
          ),
        ],
      ),
    );
  }
}

/// 关键字检索POI
class KeywordPoiScreen extends StatefulWidget {
  @override
  _KeywordPoiScreenState createState() => _KeywordPoiScreenState();
}

class _KeywordPoiScreenState extends State<KeywordPoiScreen>
    with AmapSearchDisposeMixin {
  final _keywordController = TextEditingController(text: '肯德基');
  final _cityController = TextEditingController(text: '杭州');

  List<String> _poiTitleList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(title: Text('关键字检索POI')),
      body: Column(
        children: <Widget>[
          TextFormField(
            controller: _keywordController,
            decoration: InputDecoration(hintText: '输入关键字'),
          ),
          TextFormField(
            controller: _cityController,
            decoration: InputDecoration(hintText: '输入城市'),
          ),
          RaisedButton(
            onPressed: () async {
              final poiList = await AmapSearch.searchKeyword(
                _keywordController.text,
                city: _cityController.text,
              );

              Stream.fromIterable(poiList)
                  .asyncMap((it) async =>
                      'title: ' +
                      (await it.title) +
                      ', address: ' +
                      (await it.address) +
                      ', businessArea: ' +
                      (await it.businessArea) +
                      ', ' +
                      (it.latLng).toString())
                  .toList()
                  .then((it) => setState(() => _poiTitleList = it));
            },
            child: Text('搜索'),
          ),
          Expanded(child: ScrollableText(_poiTitleList.join("\n"))),
        ],
      ),
    );
  }
}

/// 附近检索POI
class AroundPoiScreen extends StatefulWidget {
  @override
  _AroundPoiScreenState createState() => _AroundPoiScreenState();
}

class _AroundPoiScreenState extends State<AroundPoiScreen>
    with AmapSearchDisposeMixin {
  final _keywordController = TextEditingController();
  final _typeController = TextEditingController();
  final _latController = TextEditingController(text: '29.08');
  final _lngController = TextEditingController(text: '119.65');

  List<String> _poiTitleList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(title: Text('周边检索POI')),
      body: Column(
        children: <Widget>[
          TextFormField(
            controller: _keywordController,
            decoration: InputDecoration(hintText: '输入关键字'),
          ),
          TextFormField(
            controller: _typeController,
            decoration: InputDecoration(hintText: '输入类别'),
          ),
          Row(
            children: <Widget>[
              Flexible(
                child: TextField(
                  controller: _latController,
                  decoration: InputDecoration(hintText: '输入纬度'),
                ),
              ),
              Flexible(
                child: TextField(
                  controller: _lngController,
                  decoration: InputDecoration(hintText: '输入经度'),
                ),
              ),
            ],
          ),
          RaisedButton(
            onPressed: () async {
              final poiList = await AmapSearch.searchAround(
                LatLng(
                  double.tryParse(_latController.text) ?? 29.08,
                  double.tryParse(_lngController.text) ?? 119.65,
                ),
                keyword: _keywordController.text,
                type: _typeController.text,
              );

              Stream.fromIterable(poiList)
                  .asyncMap((it) async =>
                      'title: ' +
                      (await it.title) +
                      ', address: ' +
                      (await it.address) +
                      ', businessArea: ' +
                      (await it.businessArea) +
                      ', ' +
                      (it.latLng).toString())
                  .toList()
                  .then((it) => setState(() => _poiTitleList = it));
            },
            child: Text('搜索'),
          ),
          Expanded(child: ScrollableText(_poiTitleList.join("\n"))),
        ],
      ),
    );
  }
}

/// 输入提示
class InputTipScreen extends StatefulWidget {
  @override
  _InputTipScreenState createState() => _InputTipScreenState();
}

class _InputTipScreenState extends State<InputTipScreen>
    with AmapSearchDisposeMixin {
  final _keywordController = TextEditingController(text: '肯德基');
  final _cityController = TextEditingController(text: '杭州');

  List<String> _inputTipList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(title: Text('输入内容自动提示')),
      body: Column(
        children: <Widget>[
          TextFormField(
            controller: _keywordController,
            decoration: InputDecoration(hintText: '输入关键字'),
          ),
          TextFormField(
            controller: _cityController,
            decoration: InputDecoration(hintText: '输入所在城市'),
          ),
          RaisedButton(
            onPressed: () async {
              final inputTipList = await AmapSearch.fetchInputTips(
                _keywordController.text,
                city: _cityController.text,
              );

              Stream.fromIterable(inputTipList)
                  .asyncMap((it) => it.toFutureString())
                  .toList()
                  .then((it) => setState(() => _inputTipList = it));
            },
            child: Text('搜索'),
          ),
          Expanded(child: ScrollableText(_inputTipList.join("\n"))),
        ],
      ),
    );
  }
}
