import 'package:binghan_mobile/viewmodels/order_viewmodel.dart';
import 'package:binghan_mobile/views/_helpers/text_helper.dart';
import 'package:binghan_mobile/views/_helpers/ui_helpers.dart';
import 'package:binghan_mobile/views/_widgets/ColorLoader.dart';
import 'package:binghan_mobile/views/_widgets/Paragraft.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:binghan_mobile/views/base_view.dart';

class OrderTrackView extends StatefulWidget {
  const OrderTrackView({super.key});

  @override
  State<OrderTrackView> createState() => _OrderTrackViewState();
}

class _OrderTrackViewState extends State<OrderTrackView> {
  @override
  Widget build(BuildContext context) {
    Color bgColor = Theme.of(context).scaffoldBackgroundColor;
    return BaseView<OrderViewModel>(
      onModelReady: (model) {
        // model.initInvoiceDetail();
        model.initTrack();
      },
      statusBarTheme: Brightness.dark,
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: bgColor,
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            title: Text("Lacak", style: textMedium),
          ),
          body: Stack(
            children: <Widget>[
              SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    (model.invoiceMultiHeader == null)
                        ? Container(
                            height: MediaQuery.of(context).size.height - 80,
                            child: Center(child: ColorLoader2()),
                          )
                        : Column(children: <Widget>[CartList(model: model)]),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class CartList extends StatelessWidget {
  final OrderViewModel model;

  const CartList({required this.model, super.key});

  @override
  Widget build(BuildContext context) {
    // bool isExpanded = false;
    var width = MediaQuery.of(context).size.width;

    Color colorPrimary = Theme.of(context).primaryColor;
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            UIHelper.verticalSpaceMedium(),
            Text("Nomor Resi", style: textThin),
            Text("${model.invoiceMultiHeader.invoiceDate}"),
            UIHelper.horizontalLine(
              width: double.infinity,
              margin: EdgeInsets.symmetric(vertical: 10),
            ),
            rowDetail(
              first: "Tanggal Pengiriman",
              second: "${model.invoiceMultiHeader.invoiceDateFormated}",
            ),
            rowDetail(
              first: "Kurir",
              second: "${model.invoiceMultiHeader.shippingMethod}",
            ),
            rowDetail(
              first: "Service Code",
              second: "${model.invoiceMultiHeader.shippingOptions}",
            ),
            UIHelper.verticalSpaceMedium(),
            UIHelper.horizontalLine(
              width: double.infinity,
              margin: EdgeInsets.symmetric(vertical: 10),
            ),
            Paragraft(
              text: "Status",
              color: Colors.black54,
              textStyle: textThin,
            ),
            Paragraft(text: "Shipping"),
            UIHelper.verticalSpaceMedium(),
            ListView.builder(
              itemCount: model.listManifest.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, i) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: width * 0.18 - 10,
                      child: Column(
                        children: <Widget>[
                          Container(
                            width: 18,
                            height: 18,
                            decoration: BoxDecoration(
                              color: colorPrimary,
                              shape: BoxShape.circle,
                            ),
                          ),
                          i < model.listManifest.length - 1
                              ? Container(
                                  width: 2,
                                  height: 25,
                                  margin: const EdgeInsets.only(top: 5),
                                  decoration: BoxDecoration(
                                    color: colorPrimary,
                                    shape: BoxShape.rectangle,
                                  ),
                                )
                              : SizedBox(width: 0),
                        ],
                      ),
                    ),
                    Container(
                      width: width * 0.82 - 10,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Paragraft(
                                text: formatDate(
                                  model.listManifest[i].manifestDate ??
                                      DateTime.now(),
                                  [d, '-', mm, '-', yyyy],
                                ),
                                textStyle: textThin,
                                color: Colors.black54,
                              ),
                              Paragraft(
                                textStyle: textThin,
                                text: "${model.listManifest[i].manifestTime}",
                                color: Colors.black54,
                              ),
                            ],
                          ),
                          Paragraft(
                            text:
                                "${model.listManifest[i].manifestDescription}",
                            color: Colors.black54,
                            textStyle: textThin,
                          ),
                          UIHelper.verticalSpaceSmall(),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
            // SizedBox(
            //   width: double.infinity,
            //   height: 50,
            //   child: RaisedButton(
            //     onPressed: () {},
            //     color: _colorPrimary,
            //     child: Paragraft(
            //       color: Colors.white,
            //       text: "Pesanan Diterima",
            //     ),
            //   ),
            // )
            // rowDetail(first: "Ongkos Kirim", second: formatIDR(model.totalOngkir))
          ],
        ),
      ),
    );
  }

  Widget rowDetail({
    String? first,
    String? second,
    Color secondColor = Colors.black,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(first ?? ""),
        Text(
          second ?? "",
          style: textThin.merge(TextStyle(color: secondColor)),
        ),
      ],
    );
  }

  Widget rowDetail2({
    required BuildContext context,
    String? first,
    String? second,
    Color secondColor = Colors.black,
  }) {
    var width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        SizedBox(
          width: width * 0.6,
          child: Text(first ?? "", overflow: TextOverflow.clip, maxLines: 1),
        ),
        SizedBox(
          width: width * 0.3,
          child: Text(
            second ?? "",
            overflow: TextOverflow.clip,
            style: textThin.merge(TextStyle(color: secondColor)),
          ),
        ),
      ],
    );
  }
}
