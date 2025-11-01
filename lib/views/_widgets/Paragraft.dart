import 'package:flutter/material.dart';

class Paragraft extends StatelessWidget {
  final String text;
  final TextStyle textStyle;
  final Color color;
  final double fontSize;
  final TextOverflow textOverflow;
  final TextAlign textAlign;

  Paragraft(
      {required this.text,
      this.textStyle,
      this.color,
      this.fontSize,
      this.textAlign,
      this.textOverflow = TextOverflow.clip,
      Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      overflow: textOverflow,
      style: TextStyle(
              color: color != null ? color : Theme.of(context).primaryColor)
          .merge(textStyle)
          .merge(TextStyle(fontSize: fontSize)),
    );
  }
}
