import 'package:binghan_mobile/models/cart.dart';
import 'package:binghan_mobile/models/city.dart';
import 'package:binghan_mobile/models/district.dart';
import 'package:binghan_mobile/models/province.dart';
import 'package:binghan_mobile/models/warehouse.dart';
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
  const Delivery({super.key});

  @override
  State<Delivery> createState() => _DeliveryState();
}

class _DeliveryState extends State<Delivery> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    Color bgColor = Theme.of(context).scaffoldBackgroundColor;
    return BaseView<PaymentViewModel>(
      onModelReady: (model) {
        model.init();
      },
      statusBarTheme: Brightness.dark,
      builder: (context, model, child) {
        var colorPrimary = Theme.of(context).primaryColor;
        return Scaffold(
          backgroundColor: bgColor,
          bottomNavigationBar: new BottomBar(
            model: model,
            width: width,
            colorPrimary: colorPrimary,
          ),
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            title: Text("Pengiriman", style: textMedium),
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
  final PaymentViewModel model;

  const BottomBar({
    super.key,
    this.width,
    this.colorPrimary,
    required this.model,
  });

  final double? width;
  final Color? colorPrimary;

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
                text: formatIDR(model.subTotal),
                textStyle: textThinBold,
                color: colorPrimary,
              ),
            ],
          ),
          UIHelper.horizontalSpaceSmall(),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: UIHelper.marginSymmetric(15, 20),
              backgroundColor: colorPrimary,
            ),
            onPressed: model.btnText == "Pilih"
                ? null
                : () {
                    model.goToPaymentOrCourier();
                  },
            child: Paragraft(text: model.btnText, color: Colors.white),
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
    return SizedBox(
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
                  FindDropdown<ListWarehouse>(
                    showSearchBox: false,
                    items: model.listWarehouse,
                    onChanged: (ListWarehouse? data) {
                      if (data != null) {
                        model.setWarehouse(data);
                      }
                    },
                    dropdownBuilder:
                        (BuildContext context, ListWarehouse? data) {
                          return DropdownInput(
                            value: model.warehouse,
                            title: "Warehouse from",
                            displayName: (model.warehouse != null)
                                ? model.warehouse?.name
                                : "",
                          );
                        },
                    dropdownItemBuilder:
                        (BuildContext context, ListWarehouse data, bool isSel) {
                          return ListTile(
                            leading: Icon(Icons.search),
                            title: Text(data.name ?? ''),
                          );
                        },
                  ),
                  InputAuto(
                    name: "Cara Pengiriman",
                    value: model.deliveryMethod,
                    onChange: (String? data) {
                      if (data != null) {
                        model.setCaraPengiriman(data);
                      }
                    },
                    isExpanded: true,
                    list: <String>["Antar", "Ambil Ditempat"],
                  ),
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
                          onChanged: (ListProvince? data) {
                            if (data != null) {
                              model.setProvince(data);
                            }
                          },
                          dropdownBuilder:
                              (BuildContext context, ListProvince? data) {
                                return DropdownInput(
                                  value: model.province,
                                  title: "Provinsi",
                                  displayName: model.province != null
                                      ? model.province!.province!
                                      : "",
                                );
                              },
                          dropdownItemBuilder:
                              (
                                BuildContext context,
                                ListProvince data,
                                bool isSel,
                              ) {
                                return ListTile(
                                  leading: Icon(Icons.search),
                                  title: Text(data.province ?? ''),
                                );
                              },
                        ),
                        FindDropdown<ListCity>(
                          onFind: (String filter) {
                            return model.getCity(filter);
                          },
                          onChanged: (ListCity? data) {
                            if (data != null) {
                              model.setCity(data);
                            }
                          },
                          dropdownBuilder:
                              (BuildContext context, ListCity? data) {
                                return DropdownInput(
                                  value: model.city,
                                  title: "Kota",
                                  displayName: model.city != null
                                      ? model.city!.cityName!
                                      : "",
                                );
                              },
                          dropdownItemBuilder:
                              (
                                BuildContext context,
                                ListCity data,
                                bool isSel,
                              ) {
                                return ListTile(
                                  leading: Icon(Icons.search),
                                  title: Text(data.cityName ?? ''),
                                );
                              },
                        ),
                        FindDropdown<ListDistrict>(
                          onFind: (String filter) {
                            return model.getDistrict(filter);
                          },
                          onChanged: (ListDistrict? data) {
                            if (data != null) {
                              model.setDistrict(data);
                            }
                          },
                          dropdownBuilder:
                              (BuildContext context, ListDistrict? data) {
                                return DropdownInput(
                                  value: model.district,
                                  title: "Kecamatan",
                                  displayName: model.district != null
                                      ? model.district!.subdistrictName!
                                      : "",
                                );
                              },
                          dropdownItemBuilder:
                              (
                                BuildContext context,
                                ListDistrict data,
                                bool isSel,
                              ) {
                                return ListTile(
                                  leading: Icon(Icons.search),
                                  title: Text(data.subdistrictName ?? ''),
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
      ),
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
                  placeholder: AssetImage('assets/images/loading.gif'),
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
}

class DropdownInput<T> extends StatelessWidget {
  const DropdownInput({
    super.key,
    this.displayName,
    this.title,
    required this.value,
  });

  final T value;
  final String? title;
  final String? displayName;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 2,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          alignment: Alignment.centerLeft,
          child: ListTile(
            contentPadding: EdgeInsets.all(0),
            trailing: Icon(Icons.arrow_drop_down_circle),
            title: Text(
              title ?? '',
              style: textSmall.merge(
                TextStyle(color: Theme.of(context).primaryColor),
              ),
            ),
            subtitle: (value != null)
                ? Text(
                    displayName ?? '',
                    style: textMedium.merge(TextStyle(color: Colors.black)),
                  )
                : Text("Pilih $title"),
          ),
        ),
        SizedBox(height: 0),
      ],
    );
  }
}
