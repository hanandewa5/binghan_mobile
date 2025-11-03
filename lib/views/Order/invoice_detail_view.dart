import 'package:binghan_mobile/viewmodels/order_viewmodel.dart';
import 'package:binghan_mobile/views/_helpers/text_helper.dart';
import 'package:binghan_mobile/views/_helpers/ui_helpers.dart';
import 'package:binghan_mobile/views/_widgets/ColorLoader.dart';
import 'package:binghan_mobile/views/_widgets/Layout/sparator.dart';
import 'package:binghan_mobile/views/_widgets/Paragraft.dart';
import 'package:flutter/material.dart';
import 'package:binghan_mobile/views/base_view.dart';

class InvoiceDetailView extends StatefulWidget {
  const InvoiceDetailView({super.key});

  @override
  State<InvoiceDetailView> createState() => _InvoiceDetailViewState();
}

class _InvoiceDetailViewState extends State<InvoiceDetailView> {
  @override
  Widget build(BuildContext context) {
    Color bgColor = Theme.of(context).scaffoldBackgroundColor;
    return BaseView<OrderViewModel>(
      onModelReady: (model) {
        model.initInvoiceDetail();
      },
      statusBarTheme: Brightness.dark,
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: bgColor,
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            title: Text("Invoice", style: textMedium),
          ),
          body: Stack(
            children: <Widget>[
              SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    (model.invoiceDetail == null)
                        ? SizedBox(
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

    Color colorAccent = Theme.of(context).colorScheme.secondary;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Detail Tagihan", style: textLarge),
          UIHelper.verticalSpaceMedium(),
          Text("Information"),
          UIHelper.horizontalLine(
            width: double.infinity,
            margin: EdgeInsets.symmetric(vertical: 10),
          ),
          rowDetail(
            first: "Invoice Date",
            second: "${model.invoiceDetail.invoiceDateFormated}",
          ),
          rowDetail(
            first: "Invoice No",
            second: "${model.invoiceDetail.invoiceNo}",
          ),
          UIHelper.verticalSpaceSmall(),
          Text("Pembayaran"),
          UIHelper.horizontalLine(
            width: double.infinity,
            margin: EdgeInsets.symmetric(vertical: 10),
          ),
          rowDetail(
            first: "Total Harga Barang",
            // second: formatIDR(model.subPrice.toInt()),
            second: model.subPrice.toString(),
          ),
          rowDetail(
            first: "Biaya Handling",
            second: model.handlingCost.toString(),
            // second: formatIDR(model.handlingCost),
          ),
          rowDetail(
            first: "Total",
            // second: formatIDR(model.subPrice.toInt() + model.handlingCost),
            second: (model.subPrice.toInt() + model.handlingCost).toString(),
          ),
          UIHelper.horizontalLine(
            width: double.infinity,
            margin: EdgeInsets.symmetric(vertical: 10),
          ),
          rowDetail(
            first: "POP Discount",
            // second: "- ${formatIDR(model.subPopDisc)}",
            second: "- ${model.subPopDisc.toString()}",
            secondColor: Colors.redAccent,
          ),
          rowDetail(
            first: "Voucher Discount",
            // second: "- ${formatIDR(model.vDisc)}",
            second: "- ${model.vDisc.toString()}",
            secondColor: Colors.redAccent,
          ),
          rowDetail(first: "Sub Total", second: model.getSubTotal().toString()),
          UIHelper.horizontalLine(
            width: double.infinity,
            margin: EdgeInsets.symmetric(vertical: 10),
          ),
          rowDetail(
            first: "Total Ongkos Kirim",
            // second: formatIDR(model.invoiceDetail.shippingCost),
            second: model.invoiceDetail.shippingCost.toString(),
          ),
          rowDetail(
            first: "PPN (11%)",
            // second: formatIDR(
            //   (model.invoiceDetail.ppn + (model.handlingCost / 11)).toInt(),
            // ),
            second: (model.invoiceDetail.ppn + (model.handlingCost / 11))
                .toString(),
          ),
          Sparator(padding: UIHelper.marginSymmetric(15, 0)),
          rowDetail(
            first: "Total Tagihan",
            // second: formatIDR(model.grandPrice.round()),
            second: model.grandPrice.round().toString(),
            secondColor: colorAccent,
          ),
          Paragraft(
            text:
                "${model.invoiceDetail.shippingMethod?.toUpperCase()} - ${model.invoiceDetail.shippingOptions?.toUpperCase()}",
            color: Colors.black54,
            textStyle: textThin,
          ),
          Sparator(padding: EdgeInsets.only(top: 20)),
          // Product yang dibeli
          UIHelper.verticalSpaceLarge(),
          Text("Produk yang dibeli", style: textLarge),
          UIHelper.verticalSpaceMedium(),
          Text("Hongrui"),
          UIHelper.horizontalLine(
            width: double.infinity,
            margin: EdgeInsets.symmetric(vertical: 10),
          ),
          ListView.builder(
            itemCount: model.invoiceDetail.detail?.length,
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
                        "${model.invoiceDetail.detail?[i].orderFor?.firstName} ${model.invoiceDetail.detail?[i].orderFor?.lastName}",
                  ),
                  rowDetail2(
                    context: context,
                    first: "${model.invoiceDetail.detail?[i].item?.name}",

                    // second: formatIDR(
                    //   (model.invoiceDetail.detail?[i].item?.price *
                    //       model.invoiceDetail.detail?[i].qty),
                    // ),
                    second:
                        ((model.invoiceDetail.detail?[i].item?.price ?? 0) *
                                (model.invoiceDetail.detail?[i].qty ?? 0))
                            .toString(),
                  ),
                  Paragraft(
                    text:
                        // "${model.invoiceDetail.detail[i].qty} X ${formatIDR(model.invoiceDetail.detail[i].item.price)}",
                        "${model.invoiceDetail.detail?[i].qty} X ${model.invoiceDetail.detail?[i].item?.price}",
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
        Text(first ?? ''),
        Text(
          second ?? '',
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
          child: Text(first ?? '', overflow: TextOverflow.clip, maxLines: 1),
        ),
        SizedBox(
          width: width * 0.3,
          child: Text(
            second ?? '',
            overflow: TextOverflow.clip,
            style: textThin.merge(TextStyle(color: secondColor)),
          ),
        ),
      ],
    );
  }
}
