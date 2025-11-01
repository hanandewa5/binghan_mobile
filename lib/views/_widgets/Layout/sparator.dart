import 'package:flutter/material.dart';

class Sparator extends StatelessWidget {
  final double? height;
  final Color? color;
  final EdgeInsetsGeometry? padding;

  const Sparator({super.key, this.height = 1, this.padding, this.color});

  @override
  Widget build(BuildContext context) {
    var colorPrimary = Theme.of(context).primaryColor;

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        final dashWidth = 7.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (1.5 * dashWidth)).floor();
        return Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
          children: List.generate(dashCount, (_) {
            return Padding(
              padding: padding ?? EdgeInsets.zero,
              child: SizedBox(
                width: dashWidth,
                height: dashHeight,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: color ?? colorPrimary),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
