import 'package:binghan_mobile/viewmodels/payment_viewmodel.dart';
import 'package:binghan_mobile/views/_helpers/text_helper.dart';
import 'package:binghan_mobile/views/_helpers/ui_helpers.dart';
import 'package:binghan_mobile/views/_widgets/ColorLoader.dart';
import 'package:binghan_mobile/views/_widgets/Layout/sparator.dart';
import 'package:binghan_mobile/views/_widgets/Paragraft.dart';
import 'package:flutter/material.dart';
import 'package:binghan_mobile/views/base_view.dart';

class PaymentDetailView extends StatefulWidget {
  const PaymentDetailView({super.key});

  @override
  State<PaymentDetailView> createState() => _PaymentDetailViewState();
}

class _PaymentDetailViewState extends State<PaymentDetailView> {
  @override
  Widget build(BuildContext context) {
    Color bgColor = Theme.of(context).scaffoldBackgroundColor;
    return BaseView<PaymentViewModel>(
      onModelReady: (model) {
        // model.initPayment();
      },
      statusBarTheme: Brightness.dark,
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: bgColor,
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            title: Text("Payment", style: textMedium),
          ),
          body: Stack(
            children: <Widget>[
              SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    (model.busy)
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
  final PaymentViewModel model;

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
          Text("Pembayaran"),
          UIHelper.horizontalLine(
            width: double.infinity,
            margin: EdgeInsets.symmetric(vertical: 10),
          ),
          rowDetail(first: "Total Harga", second: formatIDR(model.subTotal)),
          rowDetail(
            first: "Total Ongkos Kirim",
            second: formatIDR(model.totalOngkir),
          ),
          rowDetail(
            first: "Total Potongan Harga",
            second: "- ${formatIDR(model.subDiscount)}",
            secondColor: Colors.redAccent,
          ),
          Sparator(padding: UIHelper.marginSymmetric(15, 0)),
          rowDetail(
            first: "Total Bayar",
            second: formatIDR(model.getGrandTotal()),
            secondColor: colorAccent,
          ),
          Paragraft(
            text: "${model.paymentMethod?.name}",
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
            itemCount: model.listCart.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, i) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  rowDetail2(
                    context: context,
                    first: "${model.listCart[i].items?.name}",
                    second: formatIDR(
                      ((model.listCart[i].itemPrice ?? 0) *
                          (model.listCart[i].orderQty ?? 0)),
                    ),
                  ),
                  Paragraft(
                    text:
                        "${model.listCart[i].orderQty} X ${formatIDR(model.listCart[i].itemPrice ?? 0)}",
                    color: Colors.black54,
                    textStyle: textThin,
                  ),
                  UIHelper.verticalSpaceSmall(),
                ],
              );
            },
          ),

          rowDetail(
            first: "Ongkos Kirim",
            second: formatIDR(model.totalOngkir),
          ),
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
          child: Text(
            first ?? "",
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
        Text(
          second ?? "",
          style: textThin.merge(TextStyle(color: secondColor)),
        ),
      ],
    );
  }
}
