import 'package:binghan_mobile/viewmodels/point_value_viewmodel.dart';
import 'package:binghan_mobile/views/_helpers/color_helper.dart';
import 'package:binghan_mobile/views/_helpers/text_helper.dart';
import 'package:binghan_mobile/views/_helpers/ui_helpers.dart';
import 'package:binghan_mobile/views/_widgets/Input/input_date.dart';
import 'package:binghan_mobile/views/_widgets/Layout/loader_list_page.dart';
import 'package:binghan_mobile/views/_widgets/Paragraft.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:binghan_mobile/views/base_view.dart';

class BonusPVListView extends StatefulWidget {
  const BonusPVListView({super.key});

  @override
  State<BonusPVListView> createState() => _BonusPVListViewState();
}

class _BonusPVListViewState extends State<BonusPVListView> {
  @override
  Widget build(BuildContext context) {
    var colorPrimary = Theme.of(context).primaryColor;
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return BaseView<PointValueViewModel>(
      onModelReady: (model) {
        model.initBonus();
      },
      statusBarTheme: Brightness.dark,
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          bottomNavigationBar: SafeArea(
            child: BottomBar(
              model: model,
              width: width,
              colorPrimary: colorPrimary,
            ),
          ),
          appBar: AppBar(
            centerTitle: true,
            title: Text("Bonus Transfer List", style: textMedium),
            elevation: 0,
          ),
          body: ListView(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(16),
                child: Column(
                  children: <Widget>[
                    InputDate(
                      name: "Start Date",
                      initialDate: model.startDate,
                      currDate: model.startDate,
                      onChange: (DateTime? value) {
                        if (value != null) {
                          model.setStartDateBonus(value);
                        }
                      },
                      formatDate: [MM, " ", yyyy],
                    ),
                    InputDate(
                      name: "End Date",
                      minDate: model.startDate,
                      initialDate: model.endDate,
                      currDate: model.endDate,
                      formatDate: [MM, " ", yyyy],
                      onChange: (DateTime? value) {
                        if (value != null) {
                          model.setEndDateBonus(value);
                        }
                      },
                    ),
                  ],
                ),
              ),
              Container(
                height: height * 0.6,
                padding: EdgeInsets.only(bottom: 30),
                child: LoaderListPage(
                  isLoading: model.busy,
                  length: model.listBonus.length,
                  listType: "list",
                  refresh: model.refreshInitBonus,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: model.listBonus.length,
                    // physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, i) {
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Paragraft(
                                    textStyle: textThinBold,
                                    fontSize: 18,
                                    text:
                                        "Ke : ${model.listBonus[i].diTransferKe}",
                                    color: Colors.black45,
                                  ),
                                  Paragraft(
                                    textStyle: textThinBold,
                                    fontSize: 18,
                                    text: model.listBonus[i].bulanFormated,
                                    color: Colors.black45,
                                  ),
                                ],
                              ),
                              Paragraft(
                                text:
                                    "Jumlah yang di transfer ${formatIDR(model.listBonus[i].jumlahDiTransfer ?? 0)}",
                                textStyle: textMedium,
                              ),
                            ],
                          ),
                        ),
                        // child: ListTile(
                        //   title: Paragraft(
                        //     textStyle: textThinBold,
                        //     fontSize: 18,
                        //     text: model.listBonus[i].bulanFormated,
                        //     color: Colors.black45,
                        //   ),
                        //   subtitle: Paragraft(
                        //     text: "Jumlah yang di transfer " +
                        //         formatIDR(
                        //             model.listBonus[i].jumlahDiTransfer),
                        //     textStyle: textMedium,
                        //   ),
                        // ),
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
}

class BottomBar extends StatelessWidget {
  const BottomBar({
    super.key,
    this.width,
    this.colorPrimary,
    required this.model,
  });

  final double? width;
  final Color? colorPrimary;
  final PointValueViewModel model;

  @override
  Widget build(BuildContext context) {
    return new Container(
      width: width,
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
          Paragraft(text: "Total Bonus"),
          Paragraft(text: formatIDR(model.totalBonus)),
        ],
      ),
    );
  }
}
