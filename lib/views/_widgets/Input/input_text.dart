import 'package:binghan_mobile/views/_helpers/text_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class InputText extends StatefulWidget {
  final TextEditingController? controller;
  final String? initialValue;
  final String name;
  final String? placeholder;
  final String? helperText;
  final TextStyle labelStyle;
  final bool bordered;
  final bool isRequered;
  final bool disabled;
  final int min;
  final int max;
  final TextInputType? textInputType;
  final TextStyle? style;
  final Function(String)? onChanged;
  final String? customMasking;
  final bool obscureText;

  const InputText({
    this.controller,
    this.initialValue,
    this.isRequered = false,
    this.bordered = false,
    this.disabled = false,
    this.onChanged,
    this.helperText,
    this.labelStyle = textMedium,
    this.min = 0,
    this.max = 255,
    this.placeholder,
    required this.name,
    this.textInputType,
    this.style,
    this.customMasking,
    this.obscureText = false,
    super.key,
  });

  @override
  State<InputText> createState() => _InputTextState();
}

class _InputTextState extends State<InputText> {
  MaskTextInputFormatter maskDate = MaskTextInputFormatter(
    mask: "##/##/####",
    filter: {"#": RegExp(r'[0-9]')},
  );

  // WhitelistingTextInputFormatter maskNumber =
  //     WhitelistingTextInputFormatter.digitsOnly;

  MaskTextInputFormatter maskPhone = MaskTextInputFormatter(
    mask: "#############",
    filter: {"#": RegExp(r'[0-9]')},
  );

  MaskTextInputFormatter maskNpwp = MaskTextInputFormatter(
    mask: "##.###.###.#-###.###",
    filter: {"#": RegExp(r'[0-9]')},
  );

  @override
  Widget build(BuildContext context) {
    return widget.bordered
        ? TextFormField(
            obscureText: widget.obscureText,
            initialValue: widget.initialValue,
            controller: widget.controller,
            autofocus: false,
            onChanged: widget.onChanged,
            enabled: !widget.disabled,
            onFieldSubmitted: (String inputText) {
              widget.controller?.clear();
              widget.controller?.text = inputText;
            },
            style: widget.style,
            keyboardType: widget.textInputType,
            decoration: InputDecoration(
              hintText: widget.placeholder,
              hintStyle: TextStyle(fontSize: 12),
              helperText: widget.helperText,
              helperMaxLines: 2,
              // hasFloatingPlaceholder: true,
              labelStyle: widget.labelStyle,
              // fillColor: Colors.yellowAccent,
              labelText: widget.name,
            ),
            validator: (value) {
              if (widget.isRequered) {
                if (value != null && value.isEmpty) {
                  return widget.name + ' tidak boleh kosong';
                }
              }

              if (widget.textInputType == TextInputType.emailAddress) {
                if (value != null && value.isEmpty == false) {
                  return validateEmail(value);
                }
              }

              if (widget.textInputType == TextInputType.datetime) {
                if (value != null && value.isEmpty == false) {
                  return validateDate(value);
                }
              }

              if (widget.min != 0 && widget.isRequered) {
                if ((widget.controller?.text.length ?? 0) < widget.min &&
                    widget.customMasking == null) {
                  return "${widget.name} minimal ${widget.min} digit";
                }

                if ((widget.controller?.text.length ?? 0) < widget.min &&
                    widget.customMasking == "NPWP") {
                  return "${widget.name} minimal ${widget.min - 5} digit";
                }
              }

              if (widget.max != 0) {
                if ((widget.controller?.text.length ?? 0) > widget.max &&
                    widget.customMasking == null) {
                  return "${widget.name} maksimal ${widget.max} digit";
                }
                if ((widget.controller?.text.length ?? 0) > widget.max &&
                    widget.customMasking == "NPWP") {
                  return "${widget.name} maksimal ${widget.max - 5} digit";
                }
              }
              return null;
            },
            inputFormatters: [
              // TODO Fix This
              // if (widget.textInputType == TextInputType.datetime) maskDate,
              // if (widget.textInputType == TextInputType.number) maskNumber,
              // if (widget.textInputType == TextInputType.phone &&
              //     widget.customMasking == null)
              //   maskPhone,
              // if (widget.customMasking == "NPWP") maskNpwp,
            ],
          )
        : Card(
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 18.0,
                right: 18.0,
                bottom: 5,
                top: 5,
              ),
              child: TextFormField(
                controller: widget.controller,
                style: textMedium,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintStyle: textMedium,
                  hintText: widget.name,
                ),
                // validator: (value) {
                //   if (value.isEmpty) {
                //     return widget.name + ' is required';
                //   }
                //   return null;
                // },
              ),
            ),
          );
  }

  String? validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Enter Valid Email';
    } else {
      return null;
    }
  }

  String? validateDate(String value) {
    String pattern =
        r'^(?:(?:31(\/|-|\.)(?:0?[13578]|1[02]))\1|(?:(?:29|30)(\/|-|\.)(?:0?[13-9]|1[0-2])\2))(?:(?:1[6-9]|[2-9]\d)?\d{2})$|^(?:29(\/|-|\.)0?2\3(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00))))$|^(?:0?[1-9]|1\d|2[0-8])(\/|-|\.)(?:(?:0?[1-9])|(?:1[0-2]))\4(?:(?:1[6-9]|[2-9]\d)?\d{2})$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Enter Valid Date (dd/mm/yyyy)';
    } else {
      return null;
    }
  }
}
