import 'package:binghan_mobile/models/cart.dart';
import 'package:binghan_mobile/viewmodels/payment_viewmodel.dart';
import 'package:binghan_mobile/views/_helpers/color_helper.dart';
import 'package:binghan_mobile/views/_helpers/text_helper.dart';
import 'package:binghan_mobile/views/_helpers/ui_helpers.dart';
import 'package:binghan_mobile/views/_widgets/ColorLoader.dart';
import 'package:binghan_mobile/views/_widgets/Layout/bank_container.dart';
import 'package:binghan_mobile/views/_widgets/Paragraft.dart';
import 'package:flutter/material.dart';
import 'package:binghan_mobile/views/base_view.dart';

class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    Color bgColor = Theme.of(context).scaffoldBackgroundColor;
    return BaseView<PaymentViewModel>(
      onModelReady: (model) {
        model.initPayment();
      },
      statusBarTheme: Brightness.dark,
      builder: (context, model, child) {
        var colorPrimary = Theme.of(context).primaryColor;

        return Scaffold(
          backgroundColor: bgColor,
          bottomNavigationBar: BottomBar(
            width: width,
            colorPrimary: colorPrimary,
            model: model,
          ),
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            title: Text("Pembayaran", style: textMedium),
          ),
          body: Stack(
            children: <Widget>[
              SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    (model.screenLoading)
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

class BottomBar extends StatelessWidget {
  const BottomBar({
    super.key,
    this.width,
    this.colorPrimary,
    required this.model,
  });

  final double? width;
  final Color? colorPrimary;
  final PaymentViewModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 80.0,
      padding: UIHelper.marginSymmetric(15, 20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(offset: Offset(0, -1), color: MyColors.ColorShadow),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Paragraft(
                text: "Sub Total :",
                textStyle: textThinBold,
                color: colorPrimary,
              ),
              Paragraft(
                text: formatIDR(model.getGrandTotal()),
                textStyle: textThinBold,
                color: colorPrimary,
              ),
            ],
          ),
          UIHelper.horizontalSpaceSmall(),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: UIHelper.marginSymmetric(15, 30),
              backgroundColor: colorPrimary,
            ),
            onPressed:
                model.paymentMethod == null || model.busy || model.screenLoading
                ? null
                : model.confirm,
            child: Paragraft(text: "Konfirmasi", color: Colors.white),
          ),
        ],
      ),
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
    return Column(
      children: <Widget>[
        // ListView.builder(
        //   shrinkWrap: true,
        //   physics: NeverScrollableScrollPhysics(),
        //   itemCount: model.listCart.length,
        //   itemBuilder: (context, i) {
        //     return itemList(context, model.listCart[i]);
        //   },
        // ),
        Card(
          child: Padding(
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
                rowDetail(
                  first: "Total Harga Barang",
                  second: formatIDR(model.subTotal),
                ),
                rowDetail(
                  first: "Biaya Handling",
                  second: formatIDR(model.handlingCost),
                ),
                rowDetail(first: "Total", second: formatIDR(model.getTotal())),
                UIHelper.horizontalLine(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(vertical: 5),
                ),
                rowDetail(
                  first: "POP Discount",
                  second: "- ${formatIDR(model.popDiscount)}",
                  secondColor: Colors.redAccent,
                ),
                rowDetail(
                  first: "Voucher Discount",
                  second: "- ${formatIDR(model.vDiscount)}",
                  secondColor: Colors.redAccent,
                ),
                rowDetail(
                  first: "Sub Total",
                  second: formatIDR(model.getSubTotal()),
                ),
                UIHelper.horizontalLine(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(vertical: 5),
                ),
                rowDetail(
                  first: "PPN (11%)",
                  second: formatIDR(model.getPPN()),
                ),
                rowDetail(
                  first: "Total Ongkos Kirim",
                  second: formatIDR(model.totalOngkir),
                ),
                UIHelper.horizontalLine(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(vertical: 10),
                ),
                rowDetail(
                  first: "Total Tagihan",
                  second: formatIDR(model.getGrandTotal()),
                  secondColor: colorAccent,
                ),
              ],
            ),
          ),
        ),
        // Card(child: buildPaymentMethod()),
        Card(
          child: BankContainer(
            model: model,
            list: model.listBank.xendit ?? [],
            label: "Pilih Metode Pembayaran",
          ),
        ),
      ],
    );
  }

  Widget itemList(BuildContext context, ListCart listCart) {
    var width = MediaQuery.of(context).size.width;
    return Card(
      child: Container(
        margin: UIHelper.marginVertical(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            UIHelper.horizontalSpaceSmall(),
            SizedBox(
              width: width * 0.2,
              height: width * 0.2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: FadeInImage(
                  image: NetworkImage(listCart.items?.imageUrl ?? ''),
                  fit: BoxFit.cover,
                  placeholder: AssetImage('lib/_assets/images/loading.gif'),
                ),
              ),
            ),
            UIHelper.horizontalSpaceSmall(),
            SizedBox(
              width: width * 0.7,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Paragraft(
                              text: listCart.items?.name ?? '',
                              textStyle: textThinBold,
                            ),
                            Paragraft(
                              text: formatIDR(listCart.itemPrice ?? 0),
                              textStyle: textThinBold,
                              color: Colors.black38,
                            ),
                            Paragraft(
                              text:
                                  "Pop Disc : ${formatIDR(listCart.popDis ?? 0)}",
                              textStyle: textThinBold,
                              color: Colors.black38,
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Paragraft(
                              text: "Order for",
                              textStyle: textThinBold,
                            ),
                            Paragraft(
                              text:
                                  "${listCart.member?.binghanId} - ${listCart.member?.firstName} ${listCart.member?.lastName}",
                              textStyle: textThinBold,
                              color: Colors.black38,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Text(" ${listCart.orderQty.toString()} Pcs"),
                ],
              ),
            ),
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
        Text(first ?? ''),
        Text(
          second ?? '',
          style: textThin.merge(TextStyle(color: secondColor)),
        ),
      ],
    );
  }
}
