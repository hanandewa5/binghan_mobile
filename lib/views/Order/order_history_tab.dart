import 'package:binghan_mobile/viewmodels/order_viewmodel.dart';
import 'package:binghan_mobile/views/Order/order_invoice_multi_view.dart';
import 'package:binghan_mobile/views/Order/order_invoice_view.dart';
import 'package:binghan_mobile/views/_helpers/text_helper.dart';
import 'package:binghan_mobile/views/_widgets/Paragraft.dart';
import 'package:binghan_mobile/views/base_view.dart';
import 'package:flutter/material.dart';

class OrderHistoryTabView extends StatefulWidget {
  @override
  _OrderHistoryTabViewState createState() => _OrderHistoryTabViewState();
}

class _OrderHistoryTabViewState extends State<OrderHistoryTabView>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return BaseView<OrderViewModel>(
      onModelReady: (model) {
        model.setTabController(
            TabController(length: 2, vsync: this), model.refresh);
      },
      statusBarTheme: Brightness.dark,
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Paragraft(
              text: MyStrings.textOrderHistory,
              textStyle: textMedium,
              color: Colors.white,
            ),
            bottom: TabBar(
              controller: model.tabController,
              tabs: <Widget>[
                Tab(
                  text: "Orderan Gabungan",
                ),
                Tab(
                  text: "Invoice Pribadi",
                )
              ],
            ),
          ),
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            controller: model.tabController,
            children: <Widget>[
              OrderInvoiceMultiView(),
              OrderInvoiceHeaderView(),
            ],
          ),
        );
      },
    );
  }
}
