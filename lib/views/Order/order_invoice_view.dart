import 'package:binghan_mobile/viewmodels/order_viewmodel.dart';
import 'package:binghan_mobile/views/_helpers/text_helper.dart';
import 'package:binghan_mobile/views/_helpers/ui_helpers.dart';
import 'package:binghan_mobile/views/_widgets/Layout/loader_list_page.dart';
import 'package:flutter/material.dart';
import 'package:binghan_mobile/views/base_view.dart';
import 'package:binghan_mobile/views/_widgets/Paragraft.dart';

class OrderInvoiceHeaderView extends StatefulWidget {
  const OrderInvoiceHeaderView({super.key});

  @override
  State<OrderInvoiceHeaderView> createState() => _OrderInvoiceHeaderViewState();
}

class _OrderInvoiceHeaderViewState extends State<OrderInvoiceHeaderView> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    // var _height = MediaQuery.of(context).size.height;
    return BaseView<OrderViewModel>(
      onModelReady: (model) {
        model.init();
      },
      statusBarTheme: Brightness.dark,
      builder: (context, model, child) {
        var colorAccent = Theme.of(context).colorScheme.secondary;

        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: LoaderListPage(
            refresh: model.refreshInit,
            length: model.listInvoiceHeader.length,
            isLoading: model.busy,
            child: ListView.builder(
              itemCount: model.listInvoiceHeader.length,
              itemBuilder: (context, i) {
                return cardList(model, i, width, colorAccent);
              },
            ),
          ),
        );
      },
    );
  }

  Widget cardList(
    OrderViewModel model,
    int i,
    double width,
    Color colorAccent,
  ) {
    return InkWell(
      onTap: () {
        model.goToInvoiceDetail(model.listInvoiceHeader[i]);
      },
      child: Card(
        elevation: 8,
        margin: UIHelper.marginSymmetric(10, 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: double.infinity,
              color: Color(0xFFFBF2D2),
              padding: UIHelper.marginSymmetric(5, 8),
              child: Text(
                "${model.listInvoiceHeader[i].binghanId} - ${model.listInvoiceHeader[i].name}",
                style: textThin,
              ),
            ),
            Container(
              width: double.infinity,
              padding: UIHelper.marginSymmetric(5, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "${model.listInvoiceHeader[i].invoiceDateFormated}",
                    style: textThin,
                  ),
                  Text(
                    "${model.listInvoiceHeader[i].invoiceNo}",
                    style: textThin,
                  ),
                ],
              ),
            ),
            // Divider(),
            // Container(
            //   width: double.infinity,
            //   margin: UIHelper.marginHorizontal(8),
            //   padding: UIHelper.marginVertical(8),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.start,
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: <Widget>[
            //       Container(
            //         width: _width * 0.2,
            //         height: _width * 0.2,
            //         child: ClipRRect(
            //           borderRadius: BorderRadius.circular(8.0),
            //           child: FadeInImage(
            //             image: NetworkImage(
            //                 "https://thechalkboardmag.com/wp-content/uploads/2019/08/ginseng-1.jpg"),
            //             fit: BoxFit.cover,
            //             placeholder: AssetImage('assets/images/loading.gif'),
            //           ),
            //         ),
            //       ),
            //       UIHelper.horizontalSpaceSmall(),
            //       Flexible(
            //         child: Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: <Widget>[
            //             Paragraft(
            //               text: "Ginseng Powder",
            //               textStyle: textThinBold,
            //             ),
            //             Paragraft(
            //               text: formatIDR(model.listInvoiceHeader[i].total),
            //               textStyle: textThinBold,
            //               color: Colors.black38,
            //             ),
            //             Paragraft(
            //               text: "Order for",
            //               textStyle: textThinBold,
            //             ),
            //             Paragraft(
            //               text: "${model.listInvoiceHeader[i].name}",
            //               textStyle: textThinBold,
            //               color: Colors.black38,
            //             ),
            //           ],
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            Divider(),
            Container(
              width: double.infinity,
              padding: UIHelper.marginSymmetric(5, 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Paragraft(
                    text: "Total Pembayaran",
                    textStyle: textThin,
                    color: Colors.black87,
                  ),
                  Paragraft(
                    text: formatIDR(
                      (model.listInvoiceHeader[i].subTotal ?? 0) +
                          (model.listInvoiceHeader[i].ppn ?? 0) -
                          (model.listInvoiceHeader[i].discount ?? 0),
                    ),
                    textStyle: textThin,
                    color: colorAccent,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
