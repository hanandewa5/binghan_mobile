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
  const ConfirmPaymentView({Key key}) : super(key: key);

  @override
  _ConfirmPaymentStateView createState() => _ConfirmPaymentStateView();
}

class _ConfirmPaymentStateView extends State<ConfirmPaymentView> {
  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    Color _bgColor = Theme.of(context).backgroundColor;
    return BaseView<PaymentViewModel>(
        onModelReady: (model) {
          // model.initPayment();
        },
        statusBarTheme: Brightness.dark,
        builder: (context, model, child) {
          var _colorPrimary = Theme.of(context).primaryColor;

          return Scaffold(
              backgroundColor: _bgColor,
              bottomNavigationBar: new BottomBar(
                width: _width,
                colorPrimary: _colorPrimary,
                model: model,
              ),
              appBar: AppBar(
                elevation: 0,
                centerTitle: true,
                title: Text(
                  "Konfirmasi Pembayaran",
                  style: textMedium,
                ),
              ),
              body: Stack(
                children: <Widget>[
                  SingleChildScrollView(
                    child: Container(
                        child: Column(
                      children: <Widget>[
                        (model.busy)
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

class BottomBar extends StatelessWidget {
  const BottomBar({
    Key key,
    required double width,
    required Color colorPrimary,
    this.model,
  })  : _width = width,
        _colorPrimary = colorPrimary,
        super(key: key);

  final double _width;
  final Color _colorPrimary;
  final PaymentViewModel model;

  @override
  Widget build(BuildContext context) {
    return new Container(
      width: _width,
      height: 80.0,
      padding: UIHelper.marginSymmetric(15, 20),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(offset: Offset(0, -1), color: MyColors.ColorShadow)]),
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
                color: _colorPrimary,
              ),
              Paragraft(
                text: formatIDR(model.getGrandTotal()),
                textStyle: textThinBold,
                color: _colorPrimary,
              ),
            ],
          ),
          UIHelper.horizontalSpaceSmall(),
          RaisedButton(
            padding: UIHelper.marginSymmetric(15, 30),
            color: _colorPrimary,
            child: Paragraft(
              text: "Bayar",
              color: Colors.white,
            ),
            onPressed: model.screenLoading || model.busy ? null : model.pay,
          )
        ],
      ),
    );
  }
}

class CartList extends StatelessWidget {
  final PaymentViewModel model;

  const CartList({
    this.model,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // bool isExpanded = false;

    Color _colorAccent = Theme.of(context).accentColor;
    return Column(
      children: <Widget>[
        Card(
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
              Text("Pembayaran"),
              UIHelper.horizontalLine(
                  width: double.infinity, margin: EdgeInsets.symmetric(vertical: 10)),
              rowDetail(first: "Total Harga Barang", second: formatIDR(model.subTotal)),
              rowDetail(first: "Biaya Handling", second: formatIDR(model.handlingCost)),
              rowDetail(first: "Total", second: formatIDR(model.getTotal())),
              UIHelper.horizontalLine(
                  width: double.infinity, margin: EdgeInsets.symmetric(vertical: 5)),
              rowDetail(
                  first: "POP Discount",
                  second: "- ${formatIDR(model.popDiscount)}",
                  secondColor: Colors.redAccent),
              rowDetail(
                  first: "Voucher Discount",
                  second: "- ${formatIDR(model.vDiscount)}",
                  secondColor: Colors.redAccent),
              rowDetail(first: "Sub Total", second: formatIDR(model.getSubTotal())),
              UIHelper.horizontalLine(
                  width: double.infinity, margin: EdgeInsets.symmetric(vertical: 5)),
              rowDetail(first: "Total Ongkos Kirim", second: formatIDR(model.totalOngkir)),
              rowDetail(first: "PPN (11%)", second: formatIDR(model.getPPN())),
              UIHelper.horizontalLine(
                  width: double.infinity, margin: EdgeInsets.symmetric(vertical: 10)),
              rowDetail(
                  first: "Total Tagihan",
                  second: formatIDR(model.getGrandTotal()),
                  secondColor: _colorAccent),
              if (model.deliveryMethod == "Antar")
                Paragraft(
                  text:
                      "${model.courier.name.toUpperCase()} - ${model.courierService.description.toUpperCase()}",
                  color: Colors.black54,
                  textStyle: textThin,
                )
            ],
          ),
        )),
        Card(
            child: Container(
          padding: const EdgeInsets.all(10.0),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Paragraft(
                text: "Metode Pembayaran",
              ),
              Paragraft(
                text: model.paymentMethod.name,
                textStyle: textThin,
                color: Colors.black87,
              )
            ],
          ),
        )),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: model.kcData.orderDetail.length,
              separatorBuilder: (context, i) {
                return Divider(height: 1, thickness: 2);
              },
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    UIHelper.verticalSpaceSmall(),
                    Container(
                      child: Paragraft(
                        text:
                            "Order for : ${model.kcData.orderDetail[index].binghanId} - ${model.kcData.orderDetail[index].name}",
                      ),
                    ),
                    ListView.builder(
                      itemCount: model.kcData.orderDetail[index].itemList.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, i) {
                        return itemList(context, model.kcData.orderDetail[index].itemList[i]);
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        )
      ],
    );
  }

  Widget itemList(BuildContext context, KonfirmCallbackItemList listCart) {
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
                  first: "${listCart.name}",
                  second: formatIDR((listCart.price * listCart.qty))),
              Paragraft(
                text: "${listCart.qty} X ${formatIDR(listCart.price)}",
                color: Colors.black54,
                textStyle: textThin,
              ),
            ],
          )
          // UIHelper.horizontalSpaceSmall(),
          // Container(
          //   width: _width * 0.2,
          //   height: _width * 0.2,
          //   child: ClipRRect(
          //     borderRadius: BorderRadius.circular(8.0),
          //     child: FadeInImage(
          //       image: NetworkImage(listCart.),
          //       fit: BoxFit.cover,
          //       placeholder: AssetImage('lib/_assets/images/loading.gif'),
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
            textAlign: TextAlign.right,
            overflow: TextOverflow.clip,
            style: textThin.merge(TextStyle(color: secondColor)),
          ),
        ),
      ],
    );
  }
}
