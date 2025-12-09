import 'package:binghan_mobile/models/confirm_callback.dart';
import 'package:binghan_mobile/viewmodels/payment_viewmodel.dart';
import 'package:binghan_mobile/views/_helpers/color_helper.dart';
import 'package:binghan_mobile/views/_helpers/text_helper.dart';
import 'package:binghan_mobile/views/_helpers/ui_helpers.dart';
import 'package:binghan_mobile/views/_widgets/ColorLoader.dart';
import 'package:binghan_mobile/views/_widgets/Paragraft.dart';
import 'package:flutter/material.dart';
import 'package:binghan_mobile/views/base_view.dart';

class ConfirmPaymentView extends StatefulWidget {
  const ConfirmPaymentView({super.key});

  @override
  State<ConfirmPaymentView> createState() => _ConfirmPaymentStateView();
}

class _ConfirmPaymentStateView extends State<ConfirmPaymentView> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    Color bgColor = Theme.of(context).scaffoldBackgroundColor;
    return BaseView<PaymentViewModel>(
      onModelReady: (model) {
        // model.initPayment();
      },
      statusBarTheme: Brightness.dark,
      builder: (context, model, child) {
        var colorPrimary = Theme.of(context).primaryColor;

        return Scaffold(
          backgroundColor: bgColor,
          bottomNavigationBar:  SafeArea(
            child: BottomBar(
              width: width,
              colorPrimary: colorPrimary,
              model: model,
            ),
          ),
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            title: Text("Konfirmasi Pembayaran", style: textMedium),
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

class BottomBar extends StatelessWidget {
  const BottomBar({
    super.key,
    required this.width,
    required this.colorPrimary,
    required this.model,
  });

  final double width;
  final Color colorPrimary;
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
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: colorPrimary,
            ),
            onPressed: model.screenLoading || model.busy ? null : model.pay,
            child: Paragraft(text: "Bayar", color: Colors.white),
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
                  first: "Total Ongkos Kirim",
                  second: formatIDR(model.totalOngkir),
                ),
                rowDetail(
                  first: "PPN (11%)",
                  second: formatIDR(model.getPPN()),
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
                if (model.deliveryMethod == "Antar")
                  Paragraft(
                    text:
                        "${model.courier?.name?.toUpperCase()} - ${model.courierService?.description?.toUpperCase()}",
                    color: Colors.black54,
                    textStyle: textThin,
                  ),
              ],
            ),
          ),
        ),
        Card(
          child: Container(
            padding: const EdgeInsets.all(10.0),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Paragraft(text: "Metode Pembayaran"),
                Paragraft(
                  text: model.paymentMethod?.name ?? '',
                  textStyle: textThin,
                  color: Colors.black87,
                ),
              ],
            ),
          ),
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: model.kcData?.orderDetail?.length ?? 0,
              separatorBuilder: (context, i) {
                return Divider(height: 1, thickness: 2);
              },
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    UIHelper.verticalSpaceSmall(),
                    Paragraft(
                      text:
                          "Order for : ${model.kcData?.orderDetail?[index].binghanId} - ${model.kcData?.orderDetail?[index].name}",
                    ),
                    ListView.builder(
                      itemCount:
                          model.kcData?.orderDetail?[index].itemList?.length ??
                          0,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, i) {
                        return itemList(
                          context,
                          model.kcData?.orderDetail?[index].itemList?[i],
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget itemList(BuildContext context, KonfirmCallbackItemList? listCart) {
    // var _width = MediaQuery.of(context).size.width;
    return Container(
      margin: UIHelper.marginVertical(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              rowDetail2(
                context: context,
                first: "${listCart?.name}",
                second: formatIDR(
                  (listCart?.price ?? 0) * (listCart?.qty ?? 0),
                ),
              ),
              Paragraft(
                text: "${listCart?.qty} X ${formatIDR(listCart?.price ?? 0)}",
                color: Colors.black54,
                textStyle: textThin,
              ),
            ],
          ),
          // UIHelper.horizontalSpaceSmall(),
          // Container(
          //   width: _width * 0.2,
          //   height: _width * 0.2,
          //   child: ClipRRect(
          //     borderRadius: BorderRadius.circular(8.0),
          //     child: FadeInImage(
          //       image: NetworkImage(listCart.),
          //       fit: BoxFit.cover,
          //       placeholder: AssetImage('assets/images/loading.gif'),
          //     ),
          //   ),
          // ),
          // UIHelper.horizontalSpaceSmall(),
          // Container(
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: <Widget>[
          //       Flexible(
          //         child: Column(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: <Widget>[
          //             Column(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: <Widget>[
          //                 Paragraft(
          //                   text: listCart.name,
          //                   textStyle: textThinBold,
          //                 ),
          //                 Paragraft(
          //                   text: formatIDR(listCart.price),
          //                   textStyle: textThinBold,
          //                   color: Colors.black38,
          //                 ),
          //                 Paragraft(
          //                   text:
          //                       "Pop Disc : ${formatIDR(listCart.popDiscount)}",
          //                   textStyle: textThinBold,
          //                   color: Colors.black38,
          //                 )
          //               ],
          //             ),
          //             // Column(
          //             //   crossAxisAlignment: CrossAxisAlignment.start,
          //             //   children: <Widget>[
          //             //     Paragraft(
          //             //       text: "Order for",
          //             //       textStyle: textThinBold,
          //             //     ),
          //             //     Paragraft(
          //             //       text:
          //             //           "${listCart.member.binghanId} - ${listCart.member.firstName} ${listCart.member.lastName}",
          //             //       textStyle: textThinBold,
          //             //       color: Colors.black38,
          //             //     ),
          //             //   ],
          //             // ),
          //           ],
          //         ),
          //       ),
          //       Text(
          //         "${listCart.qty.toString()} Pcs",
          //         style: textThinBold,
          //       )
          //     ],
          //   ),
          // ),
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
            textAlign: TextAlign.right,
            overflow: TextOverflow.clip,
            style: textThin.merge(TextStyle(color: secondColor)),
          ),
        ),
      ],
    );
  }
}
