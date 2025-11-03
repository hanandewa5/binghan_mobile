import 'package:binghan_mobile/viewmodels/order_viewmodel.dart';
import 'package:binghan_mobile/views/_helpers/text_helper.dart';
import 'package:binghan_mobile/views/_helpers/ui_helpers.dart';
import 'package:binghan_mobile/views/_widgets/Layout/loader_list_page.dart';
import 'package:flutter/material.dart';
import 'package:binghan_mobile/views/base_view.dart';
import 'package:binghan_mobile/views/_widgets/Paragraft.dart';

class OrderInvoiceMultiView extends StatefulWidget {
  const OrderInvoiceMultiView({super.key});

  @override
  State<OrderInvoiceMultiView> createState() => _OrderInvoiceMultiViewState();
}

class _OrderInvoiceMultiViewState extends State<OrderInvoiceMultiView> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    // var _height = MediaQuery.of(context).size.height;
    return BaseView<OrderViewModel>(
      onModelReady: (model) {
        model.initMulti();
      },
      statusBarTheme: Brightness.dark,
      builder: (context, model, child) {
        var colorAccent = Theme.of(context).colorScheme.secondary;

        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: LoaderListPage(
            refresh: model.refreshInit,
            length: model.listInvoiceMulti.length,
            isLoading: model.busy,
            child: ListView.builder(
              itemCount: model.listInvoiceMulti.length,
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
        model.goToInvoiceMultiDetail(model.listInvoiceMulti[i]);
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
                "${model.listInvoiceMulti[i].status}",
                textAlign: TextAlign.center,
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
                    "${model.listInvoiceMulti[i].invoiceDateFormated}",
                    style: textThin,
                  ),
                  Text(
                    "${model.listInvoiceMulti[i].invoiceNo}",
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
            //             placeholder: AssetImage('lib/_assets/images/loading.gif'),
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
            //               text: formatIDR(model.listInvoiceMulti[i].total),
            //               textStyle: textThinBold,
            //               color: Colors.black38,
            //             ),
            //             Paragraft(
            //               text: "Order for",
            //               textStyle: textThinBold,
            //             ),
            //             Paragraft(
            //               text: "${model.listInvoiceMulti[i].name}",
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
                    // text: formatIDR(model.listInvoiceMulti[i].total),
                    text: model.listInvoiceMulti[i].total.toString(),
                    textStyle: textThin,
                    color: colorAccent,
                  ),
                ],
              ),
            ),
            model.listInvoiceMulti[i].status == "Menunggu Pembayaran"
                ? InkWell(
                    onTap: () {
                      model.goToCaraBayar(model.listInvoiceMulti[i]);
                    },
                    child: Container(
                      width: double.infinity,
                      color: colorAccent,
                      padding: UIHelper.marginSymmetric(5, 8),
                      child: Paragraft(
                        text: "Cara Pembayaran",
                        textStyle: textMedium,
                        textAlign: TextAlign.center,
                        color: Colors.white,
                      ),
                    ),
                  )
                : model.listInvoiceMulti[i].status == "Pesanan Dikirim"
                ? Column(
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          model.goToTrack(model.listInvoiceMulti[i]);
                        },
                        child: Container(
                          width: double.infinity,
                          color: colorAccent,
                          padding: UIHelper.marginSymmetric(5, 8),
                          child: Paragraft(
                            text: "Lacak",
                            textStyle: textMedium,
                            textAlign: TextAlign.center,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          model.setComplete(model.listInvoiceMulti[i].id ?? 0);
                        },
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(width: 3, color: colorAccent),
                          ),
                          padding: UIHelper.marginSymmetric(5, 8),
                          child: Paragraft(
                            text: "Selesai",
                            textStyle: textMedium,
                            textAlign: TextAlign.center,
                            color: colorAccent,
                          ),
                        ),
                      ),
                    ],
                  )
                : SizedBox(height: 0),
          ],
        ),
      ),
    );
  }
}
