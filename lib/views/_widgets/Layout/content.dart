import 'package:flutter/material.dart';

class Content extends StatelessWidget {
  final Widget child;
  final double height;

  Content({required this.child, this.height, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: <Widget>[
          Container(
            height: height ?? MediaQuery.of(context).size.height,
            child: child,
          )
        ],
      ),
    );
  }
}
