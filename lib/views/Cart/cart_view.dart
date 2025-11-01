import 'package:binghan_mobile/models/cart.dart';
import 'package:binghan_mobile/viewmodels/cart_viewmodel.dart';
import 'package:binghan_mobile/views/_helpers/color_helper.dart';
import 'package:binghan_mobile/views/_helpers/text_helper.dart';
import 'package:binghan_mobile/views/_helpers/ui_helpers.dart';
import 'package:binghan_mobile/views/_widgets/Layout/loader_list_page.dart';
import 'package:binghan_mobile/views/_widgets/Paragraft.dart';
import 'package:flutter/material.dart';
import 'package:binghan_mobile/views/base_view.dart';

class Cart extends StatefulWidget {
  const Cart({Key key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    // Color _bgColor = Theme.of(context).backgroundColor;
    return BaseView<CartViewModal>(
        onModelReady: (model) {
          model.init();
        },
        statusBarTheme: Brightness.dark,
        builder: (context, model, child) {
          var _colorPrimary = Theme.of(context).primaryColor;
          return Scaffold(
              backgroundColor: Colors.white,
              bottomNavigationBar: BottomBar(
                width: _width,
                colorPrimary: _colorPrimary,
                model: model,
              ),
              appBar: AppBar(
                centerTitle: true,
                elevation: 0,
                title: Text(
                  "Cart",
                  style: textMedium,
                ),
              ),
              body: LoaderListPage(
                refresh: model.refreshCart,
                isLoading: model.busy,
                length: model.listCart.length,
                listType: "list",
                child: ListView.builder(
                  itemCount: model.listCart.length,
                  itemBuilder: (context, i) {
                    return CartList(model: model, listCart: model.listCart[i]);
                  },
                ),
              ));
        });
  }
}

class BottomBar extends StatelessWidget {
  final CartViewModal model;

  const BottomBar(
      {Key key,
      required double width,
      required Color colorPrimary,
      this.model})
      : _width = width,
        _colorPrimary = colorPrimary,
        super(key: key);

  final double _width;
  final Color _colorPrimary;

  @override
  Widget build(BuildContext context) {
    return new Container(
      width: _width,
      height: 80.0,
      padding: UIHelper.marginSymmetric(15, 12),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(offset: Offset(0, -1), color: MyColors.ColorShadow)
      ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox(width: 0,),
          // Flexible(
          //   child: Row(
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     children: <Widget>[
          //       CartCheckboxAll(model: model, checked: model.checkedAll),
          //       UIHelper.horizontalSpaceSmall(),
          //       Flexible(
          //         child: Paragraft(
          //           text: "Pilih Semua",
          //           textStyle: textSmall,
          //         ),
          //       )
          //     ],
          //   ),
          // ),
          Row(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Paragraft(
                    text: "Sub Total :",
                    textStyle: textThinBold,
                    color: _colorPrimary,
                  ),
                  Paragraft(
                    text: formatIDR(model.subTotal),
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
                  text: "Beli",
                  color: Colors.white,
                ),
                onPressed: model.isNull || model.listCart.length == 0
                    ? null
                    : () {
                        model.goToInvoice();
                      },
              )
            ],
          )
        ],
      ),
    );
  }
}

class CartList extends StatelessWidget {
  final ListCart listCart;
  final CartViewModal model;

  const CartList({
    this.listCart,
    this.model,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;

    return Container(
        width: _width,
        margin: UIHelper.marginHorizontal(12),
        padding: UIHelper.marginVertical(15),
        decoration: BoxDecoration(
            border:
                Border(bottom: BorderSide(color: Colors.black12, width: 1.7))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // CartCheckbox(
                //   model: model,
                //   id: listCart.id,
                // ),
                UIHelper.horizontalSpaceSmall(),
                Container(
                  width: _width * 0.3,
                  height: _width * 0.3,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: FadeInImage(
                      image: NetworkImage(listCart.items.imageUrl),
                      fit: BoxFit.cover,
                      placeholder: AssetImage('lib/_assets/images/loading.gif'),
                    ),
                  ),
                ),
                UIHelper.horizontalSpaceSmall(),
                Container(
                  // height: _width * 0.3,
                  width: _width * 0.4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Paragraft(
                                textOverflow: TextOverflow.ellipsis,
                                text: listCart.items.name,
                                textStyle: textThinBold,
                              ),
                              Paragraft(
                                text: formatIDR(listCart.itemPrice),
                                textStyle: textThinBold,
                                color: Colors.black38,
                              ),
                              Paragraft(
                                text:
                                    "Pop Disc : ${formatIDR(listCart.popDis)}",
                                textStyle: textThinBold,
                                color: Colors.black38,
                              )
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
                                    "${listCart.member.binghanId} - ${listCart.member.firstName} ${listCart.member.lastName}",
                                textStyle: textThinBold,
                                color: Colors.black38,
                              ),
                            ],
                          ),
                        ],
                      ),
                      UIHelper.verticalSpaceSmall(),
                      counter(listCart.id, listCart.orderQty),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              height: _width * 0.3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  UIHelper.verticalSpaceSmall(),
                  InkWell(
                    onTap: () {
                      model.deleteOnce(listCart.id);
                    },
                    child: Icon(
                      Icons.delete,
                      color: Colors.black26,
                      size: 28,
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }

  Widget counter(int id, int qty) {
    var _colorPrimary = MyColors.ColorPrimary;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 35,
          height: 35,
          color: _colorPrimary,
          child: InkWell(
            onTap: () {
              model.increaseOnce(id, -1);
            },
            child: Icon(
              Icons.remove,
              color: Colors.white,
            ),
          ),
        ),
        Container(
          height: 35,
          width: 50,
          color: Color(0xFFD9D9D9),
          child: Center(child: Text(qty.toString())),
        ),
        Container(
          width: 35,
          height: 35,
          color: _colorPrimary,
          child: InkWell(
            onTap: () {
              model.increaseOnce(id, 1);
            },
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
