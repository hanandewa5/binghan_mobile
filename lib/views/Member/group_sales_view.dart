import 'package:binghan_mobile/models/group_sales.dart';
import 'package:binghan_mobile/viewmodels/network_viewmodel.dart';
import 'package:binghan_mobile/views/_helpers/text_helper.dart';
import 'package:binghan_mobile/views/_helpers/ui_helpers.dart';
import 'package:binghan_mobile/views/_widgets/Input/input_date.dart';
import 'package:binghan_mobile/views/_widgets/Layout/loader_list_page.dart';
import 'package:binghan_mobile/views/_widgets/Paragraft.dart';
import 'package:flutter/material.dart';
import 'package:binghan_mobile/views/base_view.dart';

class GroupSalesView extends StatefulWidget {
  const GroupSalesView({super.key});

  @override
  State<GroupSalesView> createState() => _GroupSalesViewState();
}

class _GroupSalesViewState extends State<GroupSalesView> {
  @override
  Widget build(BuildContext context) {
    return BaseView<NetworkViewModel>(
      onModelReady: (model) {
        model.init();
      },
      statusBarTheme: Brightness.dark,
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            centerTitle: true,
            title: !model.isSearch
                ? Text(MyStrings.textNetwork, style: textMedium)
                : Container(
                    child: TextField(
                      autofocus: true,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "Search by name",
                        hintStyle: TextStyle(color: Colors.white54),
                      ),
                      controller: model.searchName,
                      onChanged: model.searchByName,
                    ),
                  ),
            actions: <Widget>[
              IconButton(
                icon: Icon(model.isSearch ? Icons.close : Icons.search),
                onPressed: model.searchClick,
              ),
              IconButton(
                icon: Icon(Icons.refresh),
                onPressed: model.refreshInit,
              ),
            ],
            elevation: 0,
          ),
          body: Column(
            children: <Widget>[
              Container(
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    AnimatedContainer(
                      padding: UIHelper.marginHorizontal(16),
                      height: model.reachTop ? 150 : 0,
                      color: model.reachTop ? Colors.white : Colors.black12,
                      duration: Duration(milliseconds: 300),
                      child: ListView(
                        children: <Widget>[
                          InputDate<DateTime>(
                            name: "Start Date",
                            initialDate: model.startDate,
                            currDate: model.startDate,
                            maxDate: model.endDate,
                            minDate: DateTime(2001, 01, 01),
                            onChange: model.setStartDate,
                          ),
                          InputDate<DateTime>(
                            name: "End Date",
                            initialDate: model.endDate,
                            minDate: model.startDate,
                            currDate: model.endDate,
                            onChange: model.setEndDate,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      padding: UIHelper.marginHorizontal(16),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Paragraft(text: "Tampilkan semua member"),
                              Switch(
                                value: model.allowZero,
                                onChanged: (val) {
                                  if (!model.busy) model.setAllowZero(val);
                                },
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Paragraft(text: "Termasuk transfer PV"),
                              Switch(
                                value: model.transfer == 1 ? true : false,
                                onChanged: (val) {
                                  if (!model.busy) model.setTransfer(val);
                                },
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Paragraft(text: "Tampilkan Group DM"),
                              Switch(
                                value: model.groupDm == 1 ? true : false,
                                onChanged: (val) {
                                  if (!model.busy) model.setGroupDM(val);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Divider(thickness: 2, height: 1),
              Expanded(
                child: Container(
                  // height: _height * 0.635,
                  // padding: EdgeInsets.only(bottom: 1),
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: LoaderListPage(
                    refresh: model.refreshInit,
                    length: model.listGroupSales.length,
                    isLoading: model.busy,
                    child: Stack(
                      children: <Widget>[
                        ListView.builder(
                          itemCount: model.listGroupSales.length,
                          shrinkWrap: true,
                          controller: model.scrollController,
                          itemBuilder: (BuildContext context, int i) {
                            return CardListMember(
                              model: model,
                              listDirect: model.listGroupSales[i],
                            );
                          },
                        ),
                        if (model.screenLoading)
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              color: Theme.of(
                                context,
                              ).primaryColor.withOpacity(0.3),
                              padding: UIHelper.marginVertical(10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(
                                    width: 28,
                                    height: 28,
                                    child: CircularProgressIndicator(),
                                  ),
                                  Paragraft(
                                    // textAlign: TextAlign.center,
                                    text: "  Loading More Data...",
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
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

class CardListMember extends StatefulWidget {
  final NetworkViewModel model;
  final ListGroupSales? listDirect;

  const CardListMember({required this.model, this.listDirect, super.key});

  @override
  State<CardListMember> createState() => _CardListMemberState();
}

class _CardListMemberState extends State<CardListMember>
    with TickerProviderStateMixin {
  bool _isExpanded = false;

  void _setExpand() {
    super.setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.model.selectUser(widget.listDirect?.memberId ?? 0);
      },
      onDoubleTap: _setExpand,
      onLongPress: _setExpand,
      child: Card(
        child: Column(
          children: <Widget>[
            ListTile(
              contentPadding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 12,
              ),
              // leading: CircleAvatar(
              //   backgroundImage: NetworkImage(
              //       "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTNLyfxPZ-nUdi6iSYGHMWikE8dvYxpWWkhSxSkz17IAMKSbTYE"),
              // ),
              isThreeLine: true,
              leading: Column(
                children: <Widget>[
                  Paragraft(
                    text: "${widget.listDirect?.level}",
                    textStyle: textMedium,
                    fontSize: 20,
                  ),
                  Paragraft(text: "Level", textStyle: textSmall),
                ],
              ),
              title: Paragraft(
                text:
                    "${widget.listDirect?.binghanId} - ${widget.listDirect?.nama}",
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Paragraft(
                    text: "UP : ${widget.listDirect?.sponsorBinghanId}",
                    textStyle: textThin,
                    color: Colors.black87,
                  ),
                  Paragraft(
                    text: "${widget.listDirect?.sponsorName}",
                    textStyle: textThin,
                    color: Colors.black87,
                  ),
                ],
              ),
              trailing: Column(
                children: <Widget>[
                  Paragraft(text: "${widget.listDirect?.pv} PV"),
                  Paragraft(text: "${widget.listDirect?.persen}%"),
                ],
              ),
            ),
            Divider(height: 1, thickness: 2),
            AnimatedSize(
              duration: Duration(milliseconds: 200),
              curve: Curves.easeOutExpo,
              child: Container(
                child: (_isExpanded)
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: UIHelper.marginSymmetric(10, 15),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Paragraft(
                                      text: "Expiry Date :",
                                      textStyle: textThin,
                                      color: Colors.black87,
                                    ),
                                    Paragraft(
                                      text:
                                          widget
                                              .listDirect
                                              ?.expireDateFormated ??
                                          '',
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Paragraft(
                                      text: "Syarat PV :",
                                      textStyle: textThin,
                                      color: Colors.black87,
                                    ),
                                    Paragraft(
                                      text: "${widget.listDirect?.syaratPv} PV",
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    : SizedBox(height: 0),
              ),
            ),
            InkWell(
              onTap: _setExpand,
              child: Container(
                margin: UIHelper.marginSymmetric(5, 15),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Paragraft(
                          text: "${_isExpanded ? 'Tutup' : 'Lihat'} Detail",
                          textStyle: textThin,
                        ),
                        Icon(
                          _isExpanded
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                          color: Theme.of(context).primaryColor,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StatusLabel extends StatelessWidget {
  const StatusLabel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: UIHelper.marginSymmetric(3, 10),
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Paragraft(text: "exp 12 Des 2019", textStyle: textThin),
    );
  }
}
