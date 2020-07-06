import 'package:amap_map_fluttify/amap_map_fluttify.dart';
import 'package:amap_search_fluttify/amap_search_fluttify.dart';

class PoiBean {
  String title;
  String address;
  LatLng latlng;
  double lat;
  double lng;
  String cityName;
  String cityCode;
  String provinceName;
  String provinceCode;
  String tel;
  String poiId;
  String businessArea;
  int distance;
  String adCode;
  String adName;

  @override
  String toString() {
    return 'PoiBean{title: $title, address: $address, latlng: $latlng, lat: $lat, lng: $lng, cityName: $cityName, cityCode: $cityCode, provinceName: $provinceName, provinceCode: $provinceCode, tel: $tel, poiId: $poiId, businessArea: $businessArea, distance: $distance, adCode: $adCode, adName: $adName}';
  }

  PoiBean(
      {this.title,
      this.address,
      this.lat,
      this.lng,
      this.cityName,
      this.cityCode,
      this.provinceName,
      this.provinceCode,
      this.tel,
      this.poiId,
      this.businessArea,
      this.distance,
      this.adCode,
      this.adName,
      this.latlng});
}

Future<List<PoiBean>> getPoiData({LatLng latLng, String keyword}) async {
  List<PoiBean> list = [];

  List<Poi> poiList;

  if (keyword != null) {
    poiList = await AmapSearch.searchKeyword(keyword);
  } else {
    poiList = await AmapSearch.searchAround(latLng);
  }

  poiList.forEach((item) async {
    list.add(PoiBean(
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

  return list;
}
