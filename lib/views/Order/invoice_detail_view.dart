import 'package:binghan_mobile/viewmodels/order_viewmodel.dart';
import 'package:binghan_mobile/views/_helpers/text_helper.dart';
import 'package:binghan_mobile/views/_helpers/ui_helpers.dart';
import 'package:binghan_mobile/views/_widgets/ColorLoader.dart';
import 'package:binghan_mobile/views/_widgets/Layout/sparator.dart';
import 'package:binghan_mobile/views/_widgets/Paragraft.dart';
import 'package:flutter/material.dart';
import 'package:binghan_mobile/views/base_view.dart';

class InvoiceDetailView extends StatefulWidget {
  const InvoiceDetailView({Key key}) : super(key: key);

  @override
  _InvoiceDetailViewState createState() => _InvoiceDetailViewState();
}

class _InvoiceDetailViewState extends State<InvoiceDetailView> {
  @override
  Widget build(BuildContext context) {
    Color _bgColor = Theme.of(context).backgroundColor;
    return BaseView<OrderViewModel>(
        onModelReady: (model) {
          model.initInvoiceDetail();
        },
        statusBarTheme: Brightness.dark,
        builder: (context, model, child) {
          return Scaffold(
              backgroundColor: _bgColor,
              appBar: AppBar(
                elevation: 0,
                centerTitle: true,
                title: Text(
                  "Invoice",
                  style: textMedium,
                ),
              ),
              body: Stack(
                children: <Widget>[
                  SingleChildScrollView(
                    child: Container(
                        child: Column(
                      children: <Widget>[
                        (model.invoiceDetail == null)
                            ? Container(
                                height: MediaQuery.of(context).size.height - 80,
                                child: Center(
                                  child: ColorLoader2(),
                                ),
                              )
                            : Column(
                                children: <Widget>[CartList(model: model)],
                              ),
                      ],
                    )),
                  ),
                ],
              ));
        });
  }
}

class CartList extends StatelessWidget {
  final OrderViewModel model;

  const CartList({
    this.model,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // bool isExpanded = false;

    Color _colorAccent = Theme.of(context).accentColor;
    return Container(
        child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Detail Tagihan",
            style: textLarge,
          ),
          UIHelper.verticalSpaceMedium(),
          Text("Information"),
          UIHelper.horizontalLine(
              width: double.infinity, margin: EdgeInsets.symmetric(vertical: 10)),
          rowDetail(first: "Invoice Date", second: "${model.invoiceDetail.invoiceDateFormated}"),
          rowDetail(first: "Invoice No", second: "${model.invoiceDetail.invoiceNo}"),
          UIHelper.verticalSpaceSmall(),
          Text("Pembayaran"),
          UIHelper.horizontalLine(
              width: double.infinity, margin: EdgeInsets.symmetric(vertical: 10)),
          rowDetail(first: "Total Harga Barang", second: formatIDR(model.subPrice.toInt())),
          rowDetail(first: "Biaya Handling", second: formatIDR(model.handlingCost)),
          rowDetail(first: "Total", second: formatIDR(model.subPrice.toInt() + model.handlingCost)),
          UIHelper.horizontalLine(
              width: double.infinity, margin: EdgeInsets.symmetric(vertical: 10)),
          rowDetail(
              first: "POP Discount",
              second: "- ${formatIDR(model.subPopDisc)}",
              secondColor: Colors.redAccent),
          rowDetail(
              first: "Voucher Discount",
              second: "- ${formatIDR(model.vDisc)}",
              secondColor: Colors.redAccent),
          rowDetail(first: "Sub Total", second: formatIDR(model.getSubTotal())),
          UIHelper.horizontalLine(
              width: double.infinity, margin: EdgeInsets.symmetric(vertical: 10)),
          rowDetail(
              first: "Total Ongkos Kirim", second: formatIDR(model.invoiceDetail.shippingCost)),
          rowDetail(
              first: "PPN (11%)",
              second: formatIDR((model.invoiceDetail.ppn + (model.handlingCost / 11)).toInt())),
          Sparator(
            padding: UIHelper.marginSymmetric(15, 0),
          ),
          rowDetail(
              first: "Total Tagihan",
              second: formatIDR(model.grandPrice.round()),
              secondColor: _colorAccent),
          Paragraft(
            text:
                "${model.invoiceDetail.shippingMethod.toUpperCase()} - ${model.invoiceDetail.shippingOptions.toUpperCase()}",
            color: Colors.black54,
            textStyle: textThin,
          ),
          Sparator(
            padding: EdgeInsets.only(top: 20),
          ),
          // Product yang dibeli
          UIHelper.verticalSpaceLarge(),
          Text(
            "Produk yang dibeli",
            style: textLarge,
          ),
          UIHelper.verticalSpaceMedium(),
          Text("Hongrui"),
          UIHelper.horizontalLine(
              width: double.infinity, margin: EdgeInsets.symmetric(vertical: 10)),
          ListView.builder(
            itemCount: model.invoiceDetail.detail.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, i) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  rowDetail2(
                      context: context,
                      first: "Order For",
                      second:
                          "${model.invoiceDetail.detail[i].orderFor.firstName} ${model.invoiceDetail.detail[i].orderFor.lastName}"),
                  rowDetail2(
                      context: context,
                      first: "${model.invoiceDetail.detail[i].item.name}",
                      second: formatIDR((model.invoiceDetail.detail[i].item.price *
                          model.invoiceDetail.detail[i].qty))),
                  Paragraft(
                    text:
                        "${model.invoiceDetail.detail[i].qty} X ${formatIDR(model.invoiceDetail.detail[i].item.price)}",
                    color: Colors.black54,
                    textStyle: textThin,
                  ),
                  UIHelper.verticalSpaceSmall(),
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
    ));
  }

  Widget rowDetail({String first, String second, Color secondColor: Colors.black}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(first),
        Text(
          second,
          style: textThin.merge(TextStyle(color: secondColor)),
        ),
      ],
    );
  }

  Widget rowDetail2(
      {BuildContext context, String first, String second, Color secondColor: Colors.black}) {
    var _width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        SizedBox(
          width: _width * 0.6,
          child: Text(
            first,
            overflow: TextOverflow.clip,
            maxLines: 1,
          ),
        ),
        SizedBox(
          width: _width * 0.3,
          child: Text(
            second,
            overflow: TextOverflow.clip,
            style: textThin.merge(TextStyle(color: secondColor)),
          ),
        ),
      ],
    );
  }
}
