import 'package:binghan_mobile/views/_helpers/text_helper.dart';
import 'package:flutter/material.dart';

class InputMulti extends StatefulWidget {
  final TextEditingController? controller;
  final String? name;
  final bool? bordered;
  final bool? isRequered;

  InputMulti({
    this.controller,
    required this.name,
    this.isRequered = false,
    this.bordered = false,
    super.key,
  });

  @override
  State<InputMulti> createState() => _InputMultiState();
}

class _InputMultiState extends State<InputMulti> {
  @override
  Widget build(BuildContext context) {
    return widget.bordered == true
        ? TextFormField(
            controller: widget.controller,
            style: textMedium,
            maxLines: null,
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(labelText: widget.name),
            validator: (value) {
              if (widget.isRequered == true) {
                if (value == null || value.isEmpty) {
                  return '${widget.name} is required';
                }
              }
              return null;
            },
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
                maxLines: null,
                keyboardType: TextInputType.multiline,
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
}
