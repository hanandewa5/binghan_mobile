import 'package:flutter/material.dart';

class CardForm extends StatelessWidget {
  final Widget child;
  final double padding;

  const CardForm({
    super.key, 
    required this.child,
    this.padding = 20
  }) ;

  @override
  Widget build(BuildContext context) {
    // return Card(
    //   elevation: 8,
    //   color: Color.fromRGBO(0, 0, 0, 0),
    //   child: ClipRRect(
    //     borderRadius: BorderRadius.circular(30),
    //     child: Container(
    //         padding: EdgeInsets.all(padding),
    //         color: Colors.transparent,
    //         width: MediaQuery.of(context).size.width * 0.95,
    //         child: child),
    //   ),
    // );

    return Container(
      width: MediaQuery.of(context).size.width * 0.95,
      padding: EdgeInsets.all(padding),
      child: child,
    );
  }
}