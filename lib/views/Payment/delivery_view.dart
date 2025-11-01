import 'package:binghan_mobile/models/cart.dart';
import 'package:binghan_mobile/models/city.dart';
import 'package:binghan_mobile/models/district.dart';
import 'package:binghan_mobile/models/province.dart';
import 'package:binghan_mobile/viewmodels/payment_viewmodel.dart';
import 'package:binghan_mobile/views/_helpers/color_helper.dart';
import 'package:binghan_mobile/views/_helpers/text_helper.dart';
import 'package:binghan_mobile/views/_helpers/ui_helpers.dart';
import 'package:binghan_mobile/views/_widgets/ColorLoader.dart';
import 'package:binghan_mobile/views/_widgets/Input/input_auto.dart';
import 'package:binghan_mobile/views/_widgets/Input/input_multi.dart';
import 'package:binghan_mobile/views/_widgets/Input/input_text.dart';
import 'package:binghan_mobile/views/_widgets/Paragraft.dart';
import 'package:find_dropdown/find_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:binghan_mobile/views/base_view.dart';

class Delivery extends StatefulWidget {
  const Delivery({Key key}) : super(key: key);

  @override
  _DeliveryState createState() => _DeliveryState();
}

class _DeliveryState extends State<Delivery> {
  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    Color _bgColor = Theme.of(context).backgroundColor;
    return BaseView<PaymentViewModel>(
        onModelReady: (model) {
          model.init();
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
                  "Pengiriman",
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
              text: model.btnText,
              color: Colors.white,
            ),
            onPressed: model.btnText == "Pilih"
                ? null
                : () {
                    model.goToPaymentOrCourier();
                  },
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
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: model.listCart.length,
              itemBuilder: (context, i) {
                return itemList(context, model.listCart[i]);
              },
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    // FindDropdown<ListWarehouse>(
                    //   showSearchBox: false,
                    //   items: model.listWarehouse,
                    //   onChanged: (ListWarehouse data) =>
                    //       model.setWarehouse(data),
                    //   dropdownBuilder: (
                    //     BuildContext context,
                    //     ListWarehouse data,
                    //   ) {
                    //     return DropdownInput(
                    //       value: model.warehouse,
                    //       title: "Warehouse from",
                    //       displayName: (model.warehouse != null)
                    //           ? model.warehouse.name
                    //           : "",
                    //     );
                    //   },
                    //   dropdownItemBuilder: (BuildContext context,
                    //       ListWarehouse data, bool isSel) {
                    //     return ListTile(
                    //       leading: Icon(Icons.search),
                    //       title: Text(data.name),
                    //     );
                    //   },
                    // ),
                    InputAuto(
                      name: "Cara Pengiriman",
                      value: model.deliveryMethod,
                      onChange: (data) {
                        model.setCaraPengiriman(data);
                      },
                      isExpanded: true,
                      list: <String>[
                        "Antar",
                        "Ambil Ditempat",
                      ],
                    )
                  ],
                ),
              ),
            ),
            (model.deliveryMethod == "Antar")
                ? Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          UIHelper.verticalSpaceMedium(),
                          Text("Alamat Penerima"),
                          FindDropdown<ListProvince>(
                            onFind: (String filter) {
                              return model.getProvince(filter);
                            },
                            onChanged: (ListProvince data) {
                              model.setProvince(data);
                            },
                            dropdownBuilder: (
                              BuildContext context,
                              ListProvince data,
                            ) {
                              return DropdownInput(
                                value: model.province,
                                title: "Provinsi",
                                displayName: model.province != null
                                    ? model.province.province
                                    : "",
                              );
                            },
                            dropdownItemBuilder: (BuildContext context,
                                ListProvince data, bool isSel) {
                              return Container(
                                child: ListTile(
                                  leading: Icon(Icons.search),
                                  title: Text(data.province),
                                ),
                              );
                            },
                          ),
                          FindDropdown<ListCity>(
                            onFind: (String filter) {
                              return model.getCity(filter);
                            },
                            onChanged: (ListCity data) {
                              model.setCity(data);
                            },
                            dropdownBuilder: (
                              BuildContext context,
                              ListCity data,
                            ) {
                              return DropdownInput(
                                value: model.city,
                                title: "Kota",
                                displayName: model.city != null
                                    ? model.city.cityName
                                    : "",
                              );
                            },
                            dropdownItemBuilder: (BuildContext context,
                                ListCity data, bool isSel) {
                              return Container(
                                child: ListTile(
                                  leading: Icon(Icons.search),
                                  title: Text(data.cityName),
                                ),
                              );
                            },
                          ),
                          FindDropdown<ListDistrict>(
                            onFind: (String filter) {
                              return model.getDistrict(filter);
                            },
                            onChanged: (ListDistrict data) {
                              model.setDistrict(data);
                            },
                            dropdownBuilder: (
                              BuildContext context,
                              ListDistrict data,
                            ) {
                              return DropdownInput(
                                value: model.district,
                                title: "Kecamatan",
                                displayName: model.district != null
                                    ? model.district.subdistrictName
                                    : "",
                              );
                            },
                            dropdownItemBuilder: (BuildContext context,
                                ListDistrict data, bool isSel) {
                              return Container(
                                child: ListTile(
                                  leading: Icon(Icons.search),
                                  title: Text(data.subdistrictName),
                                ),
                              );
                            },
                          ),
                          InputText(
                            bordered: true,
                            isRequered: true,
                            name: "Kelurahan",
                            controller: model.kelurahan,
                          ),
                          InputMulti(
                            name: "Full Address",
                            isRequered: true,
                            bordered: true,
                            controller: model.fullAddress,
                          ),
                          InputText(
                            bordered: true,
                            isRequered: true,
                            name: "Kode Pos",
                            controller: model.postCode,
                          ),
                        ],
                      ),
                    ),
                  )
                : UIHelper.verticalSpace(0),
          ],
        ));
  }

  Widget itemList(BuildContext context, ListCart listCart) {
    var _width = MediaQuery.of(context).size.width;
    return Card(
      child: Container(
        margin: UIHelper.marginVertical(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            UIHelper.horizontalSpaceSmall(),
            Container(
              width: _width * 0.2,
              height: _width * 0.2,
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
              width: _width * 0.7,
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
                  ),
                  Text(" ${listCart.orderQty.toString()} Pcs")
                ],
              ),
            ),
          ],
        ),
      ),
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
