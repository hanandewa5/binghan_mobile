import 'package:binghan_mobile/views/_helpers/color_helper.dart';
import 'package:binghan_mobile/views/_helpers/text_helper.dart';
import 'package:binghan_mobile/views/_helpers/ui_helpers.dart';
import 'package:binghan_mobile/views/_widgets/Paragraft.dart';
import 'package:flutter/material.dart';

class ProfileTile extends StatelessWidget {
  final String? title;
  final String? value;

  const ProfileTile({super.key, this.title, this.value});

  @override
  Widget build(BuildContext context) {
    var colorLabel = textMedium.merge(MyColors.ColorInputPrimary);
    var colorValue = textMedium.merge(MyColors.ColorInputAccent);
    return ListTile(
      contentPadding: UIHelper.marginHorizontal(0),
      title: Paragraft(text: title ?? '', textStyle: colorLabel),
      subtitle: Paragraft(text: value ?? "N/A", textStyle: colorValue),
    );
  }
}
