import 'package:binghan_mobile/viewmodels/point_value_viewmodel.dart';
import 'package:binghan_mobile/views/_helpers/color_helper.dart';
import 'package:binghan_mobile/views/_helpers/text_helper.dart';
import 'package:binghan_mobile/views/_helpers/ui_helpers.dart';
import 'package:binghan_mobile/views/_widgets/Input/input_date.dart';
import 'package:binghan_mobile/views/_widgets/Layout/loader_list_page.dart';
import 'package:binghan_mobile/views/_widgets/Paragraft.dart';
import 'package:flutter/material.dart';
import 'package:binghan_mobile/views/base_view.dart';

class PVListView extends StatefulWidget {
  const PVListView({Key key}) : super(key: key);

  @override
  _PVListViewState createState() => _PVListViewState();
}

class _PVListViewState extends State<PVListView> {
  @override
  Widget build(BuildContext context) {
    var _colorPrimary = Theme.of(context).primaryColor;
    var _width = MediaQuery.of(context).size.width;
    var _height = MediaQuery.of(context).size.height;

    return BaseView<PointValueViewModel>(
        onModelReady: (model) {
          model.getPVHistory();
        },
        statusBarTheme: Brightness.dark,
        builder: (context, model, child) {
          return Scaffold(
              backgroundColor: Theme.of(context).backgroundColor,
              bottomNavigationBar:
                  BottomBar(model: model, width: _width, colorPrimary: _colorPrimary),
              appBar: AppBar(
                centerTitle: true,
                title: Text("Pembelian Pribadi", style: textMedium),
                elevation: 0,
              ),
              body: ListView(
                children: <Widget>[
                  Container(
                    margin: UIHelper.marginHorizontal(16),
                    child: Column(
                      children: <Widget>[
                        InputDate(
                          name: "Start Date",
                          maxDate: model.endDate,
                          initialDate: model.startDate,
                          currDate: model.startDate,
                          onChange: model.setStartDate,
                        ),
                        InputDate(
                          name: "End Date",
                          minDate: model.startDate,
                          initialDate: model.endDate,
                          currDate: model.endDate,
                          onChange: model.setEndDate,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Paragraft(
                              text: "Termasuk transfer PV",
                            ),
                            Switch(
                              value: model.transfer == 1 ? true : false,
                              onChanged: model.setTransfer,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: _height * 0.6,
                    padding: EdgeInsets.only(bottom: 30),
                    child: LoaderListPage(
                      isLoading: model.busy,
                      listType: "list",
                      length: model.listPVHistory.length,
                      refresh: model.refreshInit,
                      child: ListView.builder(
                        itemCount: model.listPVHistory.length,
                        itemBuilder: (context, i) {
                          return Card(
                            child: ListTile(
                              title:
                                  Text(model.listPVHistory[i].transDateFormated, style: textThin),
                              subtitle: Paragraft(
                                text: model.listPVHistory[i].transType.toUpperCase(),
                              ),
                              trailing: Paragraft(
                                text: "${model.listPVHistory[i].amount} PV",
                                textStyle: textMediumLarge,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ));
        });
  }
}

class BottomBar extends StatelessWidget {
  final PointValueViewModel model;

  BottomBar({Key key, required double width, required Color colorPrimary, this.model})
      : _width = width,
        _colorPrimary = colorPrimary,
        super(key: key);

  final double _width;
  final Color _colorPrimary;

  @override
  Widget build(BuildContext context) {
    return new Container(
        width: _width,
        padding: UIHelper.marginSymmetric(15, 20),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [BoxShadow(offset: Offset(0, -1), color: MyColors.ColorShadow)]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Paragraft(
              text: "Total PV Pribadi",
            ),
            Paragraft(
              text: "${model.totalPV} PV",
            )
          ],
        ));
  }
}
