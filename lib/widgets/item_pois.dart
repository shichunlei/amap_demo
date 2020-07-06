import 'package:flutter/material.dart';

import '../bean/poi.dart';

class ItemPoiView extends StatelessWidget {
  final PoiBean poi;
  final VoidCallback onTap;

  ItemPoiView({Key key, @required this.poi, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.white,
        child: InkWell(
            child: Container(
                padding: const EdgeInsets.all(15.0),
                child: Text('${poi.title}')),
            onTap: onTap));
  }
}
