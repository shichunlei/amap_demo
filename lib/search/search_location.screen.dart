import 'package:amap_demo/bean/poi.dart';
import 'package:amap_demo/utils/misc.dart';
import 'package:amap_demo/widgets/item_pois.dart';
import 'package:amap_map_fluttify/amap_map_fluttify.dart';
import 'package:amap_search_fluttify/amap_search_fluttify.dart';
import 'package:flutter/material.dart';

class SearchLocationScreen extends StatefulWidget {
  SearchLocationScreen({Key key}) : super(key: key);

  @override
  createState() => _SearchLocationScreenState();
}

class _SearchLocationScreenState extends State<SearchLocationScreen> {
  AmapController _amapController;

  List<PoiBean> _poiTitleList = [];

  TextEditingController textEditingController;

  bool showList = true;

  bool showEdit = false;

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController()
      ..addListener(() async {
        setState(() {
//          showList = false;
        });

        searchPoisByKeyWord(textEditingController.text.toString());
      });
  }

  @override
  void dispose() {
    textEditingController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Scaffold(
          backgroundColor: Colors.grey[200],
          body: Column(children: [
            Container(
                height: 250,
                child: Stack(children: <Widget>[
                  AmapView(
                    onMapCreated: (controller) async {
                      _amapController = controller;

                      if (await requestPermission()) {
                        await _amapController
                            .showMyLocation(MyLocationOption(show: true));
                        await _amapController.setZoomLevel(18, animated: true);

                        /// 显示定位按钮
//                        await _amapController?.showLocateControl(true);
                      }
                    },

                    /// 开始移动
                    onMapMoveStart: (MapMove move) async {
                      print('开始移动: $move');

                      setState(() {
                        showList = false;
                      });
                    },

                    /// 移动结束
                    onMapMoveEnd: (MapMove move) async {
                      setState(() {
                        showList = true;
                      });

                      print(
                          '结束移动:lat: ${move.latLng.latitude}, lng: ${move.latLng.longitude}');

                      searchPoisByLatLng(move.latLng);
                    },
                  ),
                  Center(
                      child: Padding(
                          padding: const EdgeInsets.only(bottom: 40.0),
                          child: Image.asset('images/wechat_locate.png',
                              height: 40)))
                ])),
            Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8.0),
                height: 50.0,
                child: showEdit
                    ? Row(children: <Widget>[
                        Expanded(
                            child: TextField(
                                controller: textEditingController,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(10.0),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(55.0))))),
                        Container(
                            width: 50,
                            margin: EdgeInsets.only(left: 10),
                            child: FlatButton(
                                padding: EdgeInsets.only(left: 1, right: 1),
                                shape: StadiumBorder(),
                                child: Text('取消',
                                    style: TextStyle(color: Colors.blue)),
                                onPressed: () {
                                  setState(() {
                                    showEdit = false;
                                  });
                                }))
                      ])
                    : Container(
                        width: double.infinity,
                        child: FlatButton(
                            shape: StadiumBorder(),
                            child: Text('搜索'),
                            color: Colors.white,
                            onPressed: () {
                              setState(() {
                                showEdit = true;
                              });
                            }))),
            Expanded(
                child: showList
                    ? ListView.separated(
                        padding: EdgeInsets.zero,
                        itemBuilder: (_, index) {
                          return ItemPoiView(
                              poi: _poiTitleList[index],
                              onTap: () {
                                print(_poiTitleList[index].toString());
                              });
                        },
                        itemCount: _poiTitleList.length,
                        separatorBuilder: (BuildContext context, int index) =>
                            SizedBox(height: 1))
                    : Center(child: CircularProgressIndicator()))
          ])),
      Container(
          height: 100,
          child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0.0,
                  iconTheme: IconThemeData(color: Colors.black))))
    ]);
  }

  Future searchPoisByLatLng(LatLng latLng) async {
    _poiTitleList = await getPoiData(latLng: latLng).then((data) {
      return data;
    });
    print('========================');

    setState(() {
      print('----------------------');
    });

//    _poiTitleList.clear();
//
//    poiList.forEach((item) async {
//      _poiTitleList.add(PoiBean(
//          address: await item.address,
//          title: await item.title,
//          cityCode: await item.cityCode,
//          cityName: await item.cityName,
//          poiId: await item.poiId,
//          provinceCode: await item.provinceCode,
//          provinceName: await item.provinceName,
//          adName: await item.adName,
//          adCode: await item.adCode,
//          distance: await item.distance,
//          tel: await item.tel,
//          lng: await item.latLng.then((value) {
//            return value.longitude;
//          }),
//          lat: await item.latLng.then((value) {
//            return value.latitude;
//          }),
//          latlng: await item.latLng,
//          businessArea: await item.businessArea));
//    });
//
//    setState(() {});
  }

  Future searchPoisByKeyWord(String keyWord) async {
    _poiTitleList = await getPoiData(keyword: keyWord).then((data) {
      return data;
    });
    setState(() {});

//
//    poiList.forEach((item) async {
//      _poiTitleList.add(PoiBean(
//          address: await item.address,
//          title: await item.title,
//          cityCode: await item.cityCode,
//          cityName: await item.cityName,
//          poiId: await item.poiId,
//          provinceCode: await item.provinceCode,
//          provinceName: await item.provinceName,
//          adName: await item.adName,
//          adCode: await item.adCode,
//          distance: await item.distance,
//          tel: await item.tel,
//          lng: await item.latLng.then((value) {
//            return value.longitude;
//          }),
//          lat: await item.latLng.then((value) {
//            return value.latitude;
//          }),
//          latlng: await item.latLng,
//          businessArea: await item.businessArea));
//    });
//
//    setState(() {});
  }

  Future searchResult(poiList) async {
    poiList.forEach((item) async {
      _poiTitleList.add(PoiBean(
          address: await item.address,
          title: await item.title,
          cityCode: await item.cityCode,
          cityName: await item.cityName,
          poiId: await item.poiId,
          provinceCode: await item.provinceCode,
          provinceName: await item.provinceName,
          adName: await item.adName,
          adCode: await item.adCode,
          distance: await item.distance,
          tel: await item.tel,
          lng: await item.latLng.then((value) {
            return value.longitude;
          }),
          lat: await item.latLng.then((value) {
            return value.latitude;
          }),
          latlng: await item.latLng,
          businessArea: await item.businessArea));
    });

    Future.delayed(Duration(milliseconds: 500), () async {
      setState(() {});
    });
    print('+++++++++++++++++++');
  }
}
