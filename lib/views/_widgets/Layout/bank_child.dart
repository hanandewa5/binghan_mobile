import 'package:binghan_mobile/models/bank.dart';
import 'package:binghan_mobile/views/_helpers/text_helper.dart';
import 'package:binghan_mobile/views/_helpers/ui_helpers.dart';
import 'package:binghan_mobile/views/_widgets/Paragraft.dart';
import 'package:flutter/material.dart';

class BankChild extends StatelessWidget {
  const BankChild(
      {Key key,
      required this.listBankChild,
      required this.onPressed,
      required this.selected})
      : super(key: key);

  final List<ListBankChild> listBankChild;
  final Function onPressed;
  final ListBankChild selected;

  @override
  Widget build(BuildContext context) {
    var _primaryColor = Theme.of(context).primaryColor;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: listBankChild.length,
          separatorBuilder: (context, index) => Divider(
            indent: 10,
            endIndent: 10,
            color: Colors.black,
          ),
          itemBuilder: (context, i) {
            return ListTile(
              contentPadding: UIHelper.marginSymmetric(8, 15),
              // leading: (listBankChild[i].logoUrl != "")
              //     ? Image(
              //         width: 80,
              //         height: 70,
              //         fit: BoxFit.cover,
              //         image: NetworkImage(listBankChild[i].logoUrl),
              //       )
              //     : null,
              trailing: IconButton(
                icon: (selected != null && listBankChild[i].id == selected.id)
                    ? Icon(
                        Icons.radio_button_checked,
                        color: _primaryColor,
                      )
                    : Icon(Icons.radio_button_unchecked),
                onPressed: () {
                  onPressed(listBankChild[i]);
                },
              ),
              title: Text(
                listBankChild[i].name,
                style: textMedium,
              ),
              // subtitle: Paragraft(
              //   text: "${selected.id}==${listBankChild[i].id}",
              // ),
            );
          },
        ),
      ],
    );
  }
}
