import 'package:binghan_mobile/viewmodels/cart_viewmodel.dart';
import 'package:flutter/material.dart';

class CartCheckbox extends StatelessWidget {
  final int? id;
  final double? size;
  final CartViewModal? model;

  const CartCheckbox({super.key, this.id, this.size = 24, this.model});

  @override
  Widget build(BuildContext context) {
    var colorPrimary = Theme.of(context).primaryColor;
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: size ?? 24, maxWidth: size ?? 24),
      child: RawMaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        child: Icon(
          _getIconData(model?.checked(id ?? 0) == true),
          size: size,
          color: colorPrimary,
        ),
        onPressed: () {
          model?.checkOnce(id ?? 0);
        },
      ),
    );
  }

  IconData _getIconData(bool isCheck) {
    if (isCheck) return Icons.check_box;

    return Icons.check_box_outline_blank;
  }
}
