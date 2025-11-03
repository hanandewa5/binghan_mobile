import 'package:badges/badges.dart';
import 'package:binghan_mobile/views/_helpers/color_helper.dart';
import 'package:binghan_mobile/views/_helpers/text_helper.dart';
import 'package:binghan_mobile/views/_widgets/Layout/carouselWithIndicator.dart';
import 'package:binghan_mobile/views/_widgets/Paragraft.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:binghan_mobile/views/_helpers/ui_helpers.dart';
import 'package:binghan_mobile/viewmodels/dashboard_viewmodel.dart';
import 'package:binghan_mobile/views/base_view.dart';
import 'package:binghan_mobile/models/carousel.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BaseView<DashboardViewModel>(
      onModelReady: (model) {
        model.init();
      },
      statusBarTheme: Brightness.dark,
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
              onTap: model.goToWebsite,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withValues(alpha: 0.9),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Paragraft(text: "Website", color: Colors.white),
              ),
            ),
            InkWell(
              onTap: model.goToAddNewMember,
              child: Container(
                margin: EdgeInsets.only(left: 10),
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withValues(alpha: 0.9),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Paragraft(
                  text: "Daftar Member Baru",
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        appBar: AppBar(
          centerTitle: true,
          title: Text(MyStrings.textHome),
          actions: <Widget>[
            Badge(
              position: BadgePosition.topEnd(end: 0, top: 0),
              showBadge: model.notifiBadgeCounter > 0 && true,
              badgeContent: Text(
                "${model.notifiBadgeCounter}",
                style: MyColors.ColorInputWhite.merge(textSmall),
              ),
              child: IconButton(
                onPressed: model.goToNotif,
                icon: Icon(Icons.notifications),
              ),
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
            SizedBox(width: 10),
          ],
        ),
        body: model.busy
            ? Center(child: CircularProgressIndicator())
            : new BuildCard(model: model),
      ),
    );
  }
}

class BuildCard extends StatefulWidget {
  final DashboardViewModel model;

  const BuildCard({required this.model, super.key});

  @override
  State<BuildCard> createState() => _BuildCardState();
}

class _BuildCardState extends State<BuildCard> {
  int? touchedIndex;

  @override
  Widget build(BuildContext context) {
    var _fullWidth = MediaQuery.of(context).size.width;
    var _width = _fullWidth * 0.5 - 25;
    var model = widget.model;
    return RefreshIndicator(
      onRefresh: model.refreshInit,
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // UIHelper.verticalSpaceMedium(),
            (model.listCarousel.length > 0)
                ? carouselImage(model.listCarousel)
                : Text(""),
            UIHelper.verticalSpaceMedium(),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Dashboard", style: MyColors.ColorInputPrimary),
                  Container(
                    height: 1,
                    width: double.infinity,
                    color: Color(0xFFD3D3D3),
                  ),
                ],
              ),
            ),
            UIHelper.verticalSpaceMedium(),
            Container(
              width: _fullWidth,
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: <Widget>[
                  Container(
                    width: _fullWidth,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        InkWell(
                          onTap: model.goToPvList,
                          child: Container(
                            width: _width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Total PV Pribadi",
                                  style: MyColors.ColorInputPrimary,
                                ),
                                Text(
                                  "${model.pointValue <= 0 ? 0 : model.pointValue} PV",
                                  style: MyColors.ColorInputAccent,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 100,
                          width: 1,
                          color: Color(0xFFD3D3D3),
                        ),
                        InkWell(
                          onTap: model.goToPvListBulanIni,
                          child: Container(
                            width: _width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "PV Pribadi\nBulan ini",
                                  style: MyColors.ColorInputPrimary,
                                ),
                                Text(
                                  "${model.totalPVMonth <= 0 ? 0 : model.totalPVMonth} PV",
                                  style: MyColors.ColorInputAccent,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  UIHelper.verticalSpaceMedium(),
                  Container(
                    height: 1,
                    width: double.infinity,
                    color: Color(0xFFD3D3D3),
                  ),
                  UIHelper.verticalSpaceMedium(),
                  Container(
                    width: _fullWidth,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        InkWell(
                          onTap: model.goToAvailablePVTrans,
                          child: Container(
                            width: _width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "PV Pribadi yang Bisa Ditransfer",
                                  style: MyColors.ColorInputPrimary,
                                ),
                                Text(
                                  "${model.availablePV <= 0 ? 0 : model.availablePV} PV",
                                  style: MyColors.ColorInputAccent,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 100,
                          width: 1,
                          color: Color(0xFFD3D3D3),
                        ),
                        InkWell(
                          onTap: model.goToBonusPVList,
                          child: Container(
                            width: _width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Bonus Terakhir",
                                  style: MyColors.ColorInputPrimary,
                                ),
                                Text(
                                  "${model.lastDateBonus}",
                                  style: MyColors.ColorInputAccent,
                                ),
                                Text(
                                  "${model.bonusPV} PV",
                                  style: MyColors.ColorInputAccent,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            UIHelper.verticalSpaceLarge(),
            UIHelper.verticalSpaceLarge(),
          ],
        ),
      ),
    );
  }

  Widget carouselImage(List carouselList) {
    List<T> map<T>(List list, Function handler) {
      List<T> result = [];
      for (var i = 0; i < list.length; i++) {
        result.add(handler(i, list[i]));
      }

      return result;
    }

    final child = map<Widget>(carouselList, (index, ListCarousel i) {
      return Card(
        margin: EdgeInsets.all(5.0),
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
          child: Stack(
            children: <Widget>[
              FadeInImage(
                image: NetworkImage(i.fotoUrl ?? ''),
                placeholder: AssetImage('lib/_assets/images/loading.gif'),
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
              Positioned(
                bottom: 0.0,
                left: 0.0,
                right: 0.0,
                child: Container(
                  color: Theme.of(context).primaryColor,
                  padding: EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 20.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Paragraft(
                        text: i.name ?? '',
                        textStyle: textThinLarge,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }).toList();
    return CarouselWithIndicator(items: child);
  }
}
