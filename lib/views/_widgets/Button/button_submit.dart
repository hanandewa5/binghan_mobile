import 'package:binghan_mobile/views/_helpers/text_helper.dart';
import 'package:binghan_mobile/views/_helpers/ui_helpers.dart';
import 'package:flutter/material.dart';

class ButtonSubmit extends StatefulWidget {
  final bool? isLoad;
  final VoidCallback? onPressed;
  final Color? color;
  final TextStyle? textColor;
  final String? title;
  final Color? outlineColor;

  const ButtonSubmit({
    this.isLoad = false,
    this.color,
    this.textColor,
    this.title,
    this.onPressed,
    this.outlineColor,
    super.key,
  });

  @override
  State<ButtonSubmit> createState() => _ButtonSubmitState();
}

class _ButtonSubmitState extends State<ButtonSubmit> {
  @override
  Widget build(BuildContext context) {
    var colorPrimary = Theme.of(context).primaryColor;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: UIHelper.marginSymmetric(10, 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
          side: BorderSide(color: widget.outlineColor ?? colorPrimary),
        ),
        backgroundColor: widget.outlineColor != null
            ? Colors.white
            : widget.color ?? colorPrimary,
        foregroundColor: widget.color ?? colorPrimary,
      ),
      onPressed: widget.isLoad == true ? null : widget.onPressed,
      child: (widget.isLoad == true)
          ? SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
          : Text(
              widget.title ?? "SUBMIT",
              style: widget.textColor ?? textMediumWhite,
            ),
    );
  }
}
