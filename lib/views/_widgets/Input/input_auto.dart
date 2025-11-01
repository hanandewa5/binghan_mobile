import 'package:binghan_mobile/views/_helpers/color_helper.dart';
import 'package:binghan_mobile/views/_helpers/text_helper.dart';
import 'package:flutter/material.dart';

class InputAuto<T> extends StatefulWidget {
  final String? name;
  final String? value;
  final bool? isError;
  final Function(T?)? onChange;
  final List? list;
  final bool? isExpanded;

  const InputAuto({
    this.isError = false,
    this.value,
    this.onChange,
    required this.list,
    this.name,
    this.isExpanded = false,
    super.key,
  });

  @override
  State<InputAuto> createState() => _InputAutoState();
}

class _InputAutoState extends State<InputAuto> {
  @override
  Widget build(BuildContext context) {
    var colorPrimary = Theme.of(context).primaryColor;
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(width: 2, color: colorPrimary)),
            ),
            child: ListTile(
              contentPadding: EdgeInsets.only(top: 10),
              // trailing: Icon(Icons.arrow_drop_down_circle),
              title: Text(
                widget.name ?? "",
                style: textSmall.merge(
                  TextStyle(color: Theme.of(context).primaryColor),
                ),
              ),
              subtitle: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isDense: true,
                  isExpanded: widget.isExpanded == true,
                  hint: Text("Pilih ${widget.name}"),
                  value: widget.value,
                  onChanged: widget.onChange,
                  items: widget.list?.map<DropdownMenuItem<String>>((
                    dynamic value,
                  ) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
          widget.isError == true
              ? Text(
                  "${widget.name} tidak boleh kosong",
                  style: MyColors.ColorInputError.merge(textSmall),
                )
              : SizedBox(height: 0),
          // UIHelper.verticalSpaceMedium(),
          // (widget.name != null)
          //     ? Text(
          //         widget.name,
          //         style: TextStyle(
          //             fontSize: 12, color: Theme.of(context).primaryColor),
          //       )
          //     : SizedBox(
          //         width: 0,
          //       ),
          // DropdownButton<String>(
          //   isExpanded: widget.isExpanded,
          //   hint: Text("Pilih ${widget.name}"),
          //   underline: Container(
          //     height: 1.0,
          //     decoration: const BoxDecoration(
          //         border:
          //             Border(bottom: BorderSide(color: Colors.grey, width: 1))),
          //   ),
          //   value: widget.value != null ? widget.value : null,
          //   onChanged: widget.onChange,
          //   items: widget.list.map<DropdownMenuItem<String>>((dynamic value) {
          //     return DropdownMenuItem<String>(
          //       value: value,
          //       child: Text(value),
          //     );
          //   }).toList(),
          // ),
        ],
      ),
    );
  }
}
