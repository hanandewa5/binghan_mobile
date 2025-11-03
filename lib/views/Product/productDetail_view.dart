import 'package:badges/badges.dart';
import 'package:binghan_mobile/models/downline.dart';
import 'package:binghan_mobile/viewmodels/product_viewmodel.dart';
import 'package:binghan_mobile/views/_helpers/color_helper.dart';
import 'package:binghan_mobile/views/_helpers/text_helper.dart';
import 'package:binghan_mobile/views/_helpers/ui_helpers.dart';
import 'package:binghan_mobile/views/_widgets/ColorLoader.dart';
import 'package:binghan_mobile/views/_widgets/Paragraft.dart';
import 'package:find_dropdown/find_dropdown.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:binghan_mobile/views/base_view.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({super.key});

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  @override
  Widget build(BuildContext context) {
    return BaseView<ProductViewModel>(
      onModelReady: (model) {
        model.getProductItemDetail(model.selectedId);
      },
      statusBarTheme: Brightness.dark,
      builder: (context, model, child) {
        var colorPrimary = Theme.of(context).primaryColor;
        var colorAccent = Theme.of(context).colorScheme.secondary;
        var width = MediaQuery.of(context).size.width;
        return Scaffold(
          bottomNavigationBar: BottomBar(
            width: width,
            colorPrimary: colorPrimary,
            model: model,
          ),
          body: Stack(
            children: <Widget>[
              SingleChildScrollView(
                child: (model.isItemDetail)
                    ? buildContent(model, context, colorPrimary, colorAccent)
                    : loader(context),
              ),
              buildAppbar(model),
            ],
          ),
        );
      },
    );
  }

  Widget buildAppbar(ProductViewModel model) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    return Container(
      padding: UIHelper.marginSymmetric(statusBarHeight, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            onPressed: () {
              model.goBack();
            },
            icon: Icon(Icons.arrow_back),
          ),
          Badge(
            position: BadgePosition.topEnd(end: 0, top: 0),
            showBadge: model.cartBadgeCounter > 0 && true,
            badgeContent: Text(
              model.cartBadgeCounter.toString(),
              style: MyColors.ColorInputWhite.merge(textSmall),
            ),
            child: IconButton(
              onPressed: () {
                model.goToCart();
              },
              icon: Icon(Icons.shopping_cart),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildContent(
    ProductViewModel model,
    BuildContext context,
    Color colorPrimary,
    Color colorAccent,
  ) {
    return Column(
      children: <Widget>[
        Hero(
          tag: "FotoProduct${model.selectedId}",
          child: Container(
            height: MediaQuery.of(context).size.height * 0.4,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(model.itemDetail?.imageUrl ?? ''),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              UIHelper.verticalSpaceMedium(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Paragraft(
                    text: formatIDR(model.itemDetail?.price ?? 0),
                    textStyle: textThinBold,
                    fontSize: 24,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        width: 35,
                        height: 35,
                        color: colorPrimary,
                        child: InkWell(
                          onTap: () {
                            model.minJumlah();
                          },
                          child: Icon(Icons.remove, color: Colors.white),
                        ),
                      ),
                      Container(
                        height: 35,
                        width: 50,
                        color: Color(0xFFD9D9D9),
                        child: Center(child: Text(model.jumlah.toString())),
                      ),
                      Container(
                        width: 35,
                        height: 35,
                        color: colorPrimary,
                        child: InkWell(
                          onTap: () {
                            model.plusJumlah();
                          },
                          child: Icon(Icons.add, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Paragraft(
                text:
                    "Pop Disc : ${formatIDR(model.itemDetail?.popDiscount ?? 0)}",
                textStyle: textThin,
                fontSize: 18,
              ),
              // Paragraft(
              //   text: "Stock Tersedia : ${model.itemDetail.stockAvailable}",
              //   textStyle: textThin,
              //   fontSize: 18,
              // ),
              UIHelper.verticalSpaceMedium(),
              FindDropdown<ListDownline>(
                onFind: (String filter) {
                  return model.getDownline(filter);
                },
                onChanged: (ListDownline? data) {
                  if (data != null) {
                    model.setDownline(data);
                  }
                },
                dropdownBuilder: (BuildContext context, ListDownline? data) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              width: 2,
                              color: model.isDownline
                                  ? Theme.of(context).primaryColor
                                  : Theme.of(context).colorScheme.error,
                            ),
                          ),
                        ),
                        alignment: Alignment.centerLeft,
                        child: ListTile(
                          contentPadding: EdgeInsets.all(0),
                          trailing: Icon(Icons.arrow_drop_down_circle),
                          title: Paragraft(
                            text: "Order for :",
                            textStyle: textThinBold,
                            color: colorPrimary,
                            fontSize: 20,
                          ),
                          subtitle: (model.downline != null)
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Paragraft(
                                      text:
                                          "${model.downline?.binghanId} - ${model.downline?.firstName} ${model.downline?.lastName}",
                                      textStyle: textThinLarge,
                                      color: colorPrimary,
                                    ),
                                    Paragraft(
                                      text:
                                          "UP : ${model.downline?.sponsorBinghanId} - ${model.downline?.namaSponsor}",
                                      textStyle: textThin,
                                      color: colorAccent,
                                    ),
                                  ],
                                )
                              : Text("Pilih Downline"),
                        ),
                      ),
                      model.isDownline
                          ? SizedBox(height: 0)
                          : Text(
                              "Downline is requred",
                              style: MyColors.ColorInputError.merge(textSmall),
                            ),
                    ],
                  );
                },
                dropdownItemBuilder:
                    (BuildContext context, ListDownline data, bool isSel) {
                      return Container(
                        child: ListTile(
                          leading: Icon(Icons.search),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Paragraft(text: "${data.binghanId}"),
                                  if (data.status?.toLowerCase() != "active")
                                    Row(
                                      children: <Widget>[
                                        Paragraft(text: " - "),
                                        Paragraft(
                                          text: "${data.status}",
                                          color: Colors.red,
                                        ),
                                      ],
                                    ),
                                ],
                              ),
                              Paragraft(
                                text: "${data.firstName} ${data.lastName}",
                              ),
                              Paragraft(
                                text:
                                    "Up  : ${data.sponsorBinghanId}-${data.namaSponsor}",
                                textStyle: textThin,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
              ),
              UIHelper.verticalSpaceMedium(),
              Paragraft(
                text: model.itemDetail?.name ?? '',
                textStyle: textThinLarge,
              ),
              Paragraft(
                text: model.itemDetail?.specification ?? '',
                textStyle: textThin,
                color: Colors.black45,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Container loader(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Center(child: ColorLoader2()),
    );
  }
}

class BottomBar extends StatelessWidget {
  const BottomBar({
    super.key,
    required this.model,
    this.width,
    this.colorPrimary,
  });

  final double? width;
  final Color? colorPrimary;
  final ProductViewModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 80.0,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black45, blurRadius: 5)],
      ),
      child: Padding(
        padding: UIHelper.marginHorizontal(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Paragraft(text: "Total :"),
                Paragraft(text: formatIDR(model.total)),
              ],
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: UIHelper.marginSymmetric(15, 30),
                backgroundColor: colorPrimary,
              ),
              onPressed:
                  model.busy || (model.itemDetail?.stockAvailable ?? 0) <= 0
                  ? null
                  : () {
                      model.addCart();
                    },
              child: Paragraft(text: "Add To Cart", color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
