import 'package:flutter/material.dart';

class Content extends StatelessWidget {
  final Widget child;
  final double? height;

  const Content({required this.child, this.height, super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: <Widget>[
          SizedBox(
            height: height ?? MediaQuery.of(context).size.height,
            child: child,
          ),
        ],
      ),
    );
  }
}
