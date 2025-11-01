import 'package:binghan_mobile/models/member_pv.dart';
import 'package:binghan_mobile/viewmodels/point_value_viewmodel.dart';
import 'package:binghan_mobile/views/_helpers/color_helper.dart';
import 'package:binghan_mobile/views/_helpers/text_helper.dart';
import 'package:binghan_mobile/views/_helpers/ui_helpers.dart';
import 'package:binghan_mobile/views/_widgets/Layout/loader_list_page.dart';
import 'package:binghan_mobile/views/_widgets/Paragraft.dart';
import 'package:flutter/material.dart';
import 'package:binghan_mobile/views/base_view.dart';

class AvailablePVTransView extends StatefulWidget {
  const AvailablePVTransView({Key key}) : super(key: key);

  @override
  _AvailablePVTransViewState createState() => _AvailablePVTransViewState();
}

class _AvailablePVTransViewState extends State<AvailablePVTransView> {
  @override
  Widget build(BuildContext context) {
    var _colorPrimary = Theme.of(context).primaryColor;
    var _width = MediaQuery.of(context).size.width;
    // var _height = MediaQuery.of(context).size.height;
    return BaseView<PointValueViewModel>(
        onModelReady: (model) {
          model.getMemberPV();
          model.getAvailPV();
        },
        statusBarTheme: Brightness.dark,
        builder: (context, model, child) {
          return Scaffold(
              bottomNavigationBar: BottomBar(
                  model: model, width: _width, colorPrimary: _colorPrimary),
              backgroundColor: Theme.of(context).backgroundColor,
              appBar: AppBar(
                centerTitle: true,
                title: Text(
                  "PV Transfer",
                  style: textMedium,
                ),
                elevation: 0,
              ),
              body: LoaderListPage(
                refresh: model.refreshInit,
                length: model.listMemberPV.length,
                listType: "list",
                isLoading: model.busy,
                child: ListView(
                  children: <Widget>[
                    ListView.builder(
                      itemCount: model.listMemberPV.length,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int i) {
                        return CardListMember(
                          model: model,
                          listDirect: model.listMemberPV[i],
                        );
                      },
                    ),
                  ],
                ),
              ));
        });
  }
}

class CardListMember extends StatelessWidget {
  final PointValueViewModel model;
  final ListMemberPV listDirect;

  const CardListMember({
    this.model,
    this.listDirect,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _colorAccent = Theme.of(context).accentColor;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          // leading: CircleAvatar(
          //   backgroundImage: NetworkImage(
          //       "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTNLyfxPZ-nUdi6iSYGHMWikE8dvYxpWWkhSxSkz17IAMKSbTYE"),
          // ),
          title: Paragraft(
            text: "${listDirect.binghanId} - ${listDirect.firstName}",
          ),
          subtitle: Paragraft(
            text:
                "PV bisa ditransfer ${model.getAvPV(listDirect.availableTransfer)} PV",
            textStyle: textThin,
            color: Colors.black,
          ),
          trailing: RaisedButton(
            color: _colorAccent,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            child: Paragraft(
              text: "Trans PV",
              color: Colors.white,
            ),
            onPressed: model.getAvPV(listDirect.availableTransfer) <= 0
                ? null
                : () {
                    model.goToTansferPV(listDirect);
                  },
          ),
        ),
      ),
    );
  }
}

class BottomBar extends StatelessWidget {
  final PointValueViewModel model;

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
      padding: UIHelper.marginSymmetric(15, 20),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(offset: Offset(0, -1), color: MyColors.ColorShadow)
      ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Paragraft(
            text: "PV yang bisa ditransfer",
            color: _colorPrimary,
          ),
          Paragraft(
            text: "${model.availablePV <= 0 ? 0 : model.availablePV} PV",
            color: _colorPrimary,
          ),
        ],
      ),
    );
  }
}
