import 'package:binghan_mobile/models/bank.dart';
import 'package:binghan_mobile/viewmodels/payment_viewmodel.dart';
import 'package:flutter/material.dart';

import 'bank_child.dart';

class BankContainer extends StatelessWidget {
  const BankContainer({
    super.key,
    required this.model,
    required this.list,
    required this.label,
  }) ;

  final PaymentViewModel model;
  final List<ListBankChild> list;
  final String label;

  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
      animationDuration: Duration(milliseconds: 500),
      expansionCallback: (int item, bool status) {
        model.setExpanded(label);
      },
      children: [
        ExpansionPanel(
            isExpanded: model.isExpanded == label ? true : false,
            headerBuilder: (BuildContext context, bool isExpand) {
              return Padding(
                padding: EdgeInsets.only(left: 8, top: 10),
                child: Text(label),
              );
            },
            body: BankChild(
                listBankChild: list,
                onPressed: model.setPaymentMethod,
                selected: model.paymentMethod))
      ],
    );
  }
}
