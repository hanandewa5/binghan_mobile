import 'package:badges/badges.dart';
import 'package:binghan_mobile/viewmodels/product_viewmodel.dart';
import 'package:binghan_mobile/views/_helpers/color_helper.dart';
import 'package:binghan_mobile/views/_helpers/text_helper.dart';
import 'package:binghan_mobile/views/_helpers/ui_helpers.dart';
import 'package:binghan_mobile/views/_widgets/Input/input_auto.dart';
import 'package:binghan_mobile/views/_widgets/Layout/loader_list_page.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:binghan_mobile/views/base_view.dart';

class Product extends StatefulWidget {
  const Product({super.key});

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width / 2;
    return BaseView<ProductViewModel>(
      onModelReady: (model) {
        model.init();
      },
      statusBarTheme: Brightness.dark,
      builder: (context, model, child) {
        var colorPrimary = Theme.of(context).primaryColor;
        // var _height = MediaQuery.of(context).size.height;
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            title: Text(MyStrings.textProduct, style: textMedium),
            actions: <Widget>[
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
              SizedBox(width: 10),
            ],
          ),
          body: Column(
            children: <Widget>[
              Container(
                margin: UIHelper.marginHorizontal(10),
                child: InputAuto(
                  name: "Warehouse",
                  isExpanded: true,
                  value: "Jakarta",
                  list: <String>["Jakarta"],
                  onChange: (val) {
                    print(val);
                  },
                ),
              ),
              UIHelper.verticalSpaceMedium(),
              Expanded(
                // height: _height * 0.65,
                // padding: EdgeInsets.only(bottom : _height * 0.1),
                child: LoaderListPage(
                  refresh: model.refreshProduct,
                  isLoading: model.busy,
                  length: model.listProductItem.length,
                  listType: "grid",
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: model.listProductItem.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: ((width) / (width + 70)),
                    ),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: GestureDetector(
                          onTap: () {
                            model.goToProductDetail(
                              model.listProductItem[index].id ?? 0,
                            );
                          },
                          child: buildCard(width, model, index, colorPrimary),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Card buildCard(
    double width,
    ProductViewModel model,
    int index,
    Color colorPrimary,
  ) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: width,
              height: width - 50,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Hero(
                  tag: "FotoProduct${model.listProductItem[index].id}",
                  child: FadeInImage(
                    image: NetworkImage(
                      model.listProductItem[index].imageUrl ?? '',
                    ),
                    fit: BoxFit.cover,
                    placeholder: AssetImage('lib/_assets/images/loading.gif'),
                  ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  model.listProductItem[index].name ?? '',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: textMedium.merge(MyColors.ColorInputPrimary),
                ),
                Text(
                  formatIDR(model.listProductItem[index].price ?? 0),
                  style: textMedium.merge(MyColors.ColorInputPrimary),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
