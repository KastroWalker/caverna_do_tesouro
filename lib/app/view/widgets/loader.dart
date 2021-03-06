import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  final String? text;
  const Loader({Key? key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const CircularProgressIndicator(),
          Container(child: (text == null) ? null : Text(text!)),
        ],
      ),
    );
  }
}
