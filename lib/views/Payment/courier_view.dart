import 'package:binghan_mobile/models/courier.dart';
import 'package:binghan_mobile/models/courier_service.dart';
import 'package:binghan_mobile/viewmodels/payment_viewmodel.dart';
import 'package:binghan_mobile/views/_helpers/color_helper.dart';
import 'package:binghan_mobile/views/_helpers/text_helper.dart';
import 'package:binghan_mobile/views/_helpers/ui_helpers.dart';
import 'package:binghan_mobile/views/_widgets/ColorLoader.dart';
import 'package:binghan_mobile/views/_widgets/Paragraft.dart';
import 'package:find_dropdown/find_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:binghan_mobile/views/base_view.dart';

class CourierView extends StatefulWidget {
  const CourierView({Key key}) : super(key: key);

  @override
  _CourierViewState createState() => _CourierViewState();
}

class _CourierViewState extends State<CourierView> {
  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    Color _bgColor = Theme.of(context).backgroundColor;
    return BaseView<PaymentViewModel>(
        onModelReady: (model) {
          model.initCourier();
        },
        statusBarTheme: Brightness.dark,
        builder: (context, model, child) {
          var _colorPrimary = Theme.of(context).primaryColor;
          return Scaffold(
              backgroundColor: _bgColor,
              bottomNavigationBar: new BottomBar(
                  model: model, width: _width, colorPrimary: _colorPrimary),
              appBar: AppBar(
                elevation: 0,
                centerTitle: true,
                title: Text(
                  "Pilih Kurir",
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
  final PaymentViewModel model;

  BottomBar(
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
      padding: UIHelper.marginSymmetric(15, 20),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(offset: Offset(0, -1), color: MyColors.ColorShadow)
      ]),
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
                text: formatIDR(model.subTotal),
                textStyle: textThinBold,
                color: _colorPrimary,
              ),
            ],
          ),
          UIHelper.horizontalSpaceSmall(),
          RaisedButton(
            padding: UIHelper.marginSymmetric(15, 20),
            color: _colorPrimary,
            child: Paragraft(
              text: "Pilih Pembayaran",
              color: Colors.white,
            ),
            onPressed:
                model.busy || model.courierService == null ? null : model.goToPayment,
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
    return Container(
        width: MediaQuery.of(context).size.width,
        // margin: EdgeInsets.all(10),
        child: Column(
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
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    FindDropdown<ListCourier>(
                      showSearchBox: false,
                      items: model.listCourier,
                      onChanged: (ListCourier data) => model.setCourier(data),
                      dropdownBuilder: (
                        BuildContext context,
                        ListCourier data,
                      ) {
                        return DropdownInput(
                          value: model.courier,
                          title: "Kurir",
                          displayName:
                              (model.courier != null) ? model.courier.name : "",
                        );
                      },
                      dropdownItemBuilder:
                          (BuildContext context, ListCourier data, bool isSel) {
                        return ListTile(
                          leading: Icon(Icons.search),
                          title: Text(data.name),
                        );
                      },
                    ),
                    FindDropdown<ListCourierService>(
                      showSearchBox: false,
                      items: model.listCourierService,
                      onChanged: (ListCourierService data) =>
                          model.setCourierService(data),
                      dropdownBuilder: (
                        BuildContext context,
                        ListCourierService data,
                      ) {
                        return DropdownInput(
                          value: model.courierService,
                          title: "Service",
                          displayName: (model.courierService != null)
                              ? model.courierService.service
                              : "",
                        );
                      },
                      dropdownItemBuilder: (BuildContext context,
                          ListCourierService data, bool isSel) {
                        return ListTile(
                          leading: Icon(Icons.search),
                          title: Text(data.service),
                        );
                      },
                    ),
                    UIHelper.verticalSpaceSmall(),
                    Paragraft(
                      text: "Perkiraan tiba (${model.estimateDays}) hari",
                    ),
                    rowDetail(
                        first: "Harga Total Ongkos Kirim :",
                        second: formatIDR(model.totalOngkir)),
                    rowDetail(
                        first: "Berat Total Barang :",
                        second: "${model.subWeight / 1000} kg")
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  Widget rowDetail(
      {String first, String second, Color secondColor: Colors.black}) {
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
}

class DropdownInput<T> extends StatelessWidget {
  const DropdownInput({
    Key key,
    this.displayName,
    this.title,
    required this.value,
  }) : super(key: key);

  final T value;
  final String title;
  final String displayName;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        width: 2, color: Theme.of(context).primaryColor))),
            alignment: Alignment.centerLeft,
            child: ListTile(
                contentPadding: EdgeInsets.all(0),
                trailing: Icon(Icons.arrow_drop_down_circle),
                title: Text(
                  title,
                  style: textSmall
                      .merge(TextStyle(color: Theme.of(context).primaryColor)),
                ),
                subtitle: (value != null)
                    ? Text(
                        displayName,
                        style: textMedium.merge(TextStyle(color: Colors.black)),
                      )
                    : Text("Pilih $title"))),
        SizedBox(
          height: 0,
        )
      ],
    );
  }
}
