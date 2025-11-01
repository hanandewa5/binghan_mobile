import 'package:binghan_mobile/viewmodels/cart_viewmodel.dart';
import 'package:flutter/material.dart';

class CartCheckboxAll extends StatelessWidget {
  final double size;
  final CartViewModal? model;
  final bool? checked;

  const CartCheckboxAll({super.key, this.size = 24, this.model, this.checked});

  @override
  Widget build(BuildContext context) {
    var colorPrimary = Theme.of(context).primaryColor;
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: size, maxWidth: size),
      child: RawMaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        child: Icon(
          _getIconData(checked == true),
          size: size,
          color: colorPrimary,
        ),
        onPressed: () {
          model?.checkAll();
        },
      ),
    );
  }

  IconData _getIconData(bool isCheck) {
    if (isCheck) {
      return Icons.check_box;
    }

    return Icons.check_box_outline_blank;
  }
}
