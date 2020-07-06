import 'package:flutter/material.dart';

class FutureText extends StatelessWidget {
  const FutureText(this.data, {Key key}) : super(key: key);

  final Future<String> data;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: data,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Text("${snapshot.data}");
      },
    );
  }
}
