import 'package:binghan_mobile/viewmodels/notification_viewmodel.dart';
import 'package:binghan_mobile/views/_helpers/color_helper.dart';
import 'package:binghan_mobile/views/_helpers/text_helper.dart';
import 'package:binghan_mobile/views/_widgets/Layout/loader_list_page.dart';
import 'package:binghan_mobile/views/_widgets/Paragraft.dart';
import 'package:flutter/material.dart';
import 'package:binghan_mobile/views/base_view.dart';

class NotificationListView extends StatefulWidget {
  const NotificationListView({super.key});

  @override
  State<NotificationListView> createState() => _NotificationListViewState();
}

class _NotificationListViewState extends State<NotificationListView> {
  @override
  Widget build(BuildContext context) {
    // var _width = MediaQuery.of(context).size.width;
    // var _height = MediaQuery.of(context).size.height;
    return BaseView<NotificationViewModel>(
      onModelReady: (model) {
        model.init();
      },
      statusBarTheme: Brightness.dark,
      builder: (context, model, child) {
        var height = MediaQuery.of(context).size.height;
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(
            centerTitle: true,
            title: Text("Notification", style: textMedium),
            elevation: 0,
          ),
          body: SizedBox(
            height: height,
            child: LoaderListPage(
              refresh: model.refreshInit,
              length: model.listNotification.length,
              isLoading: model.busy,
              child: ListView.separated(
                separatorBuilder: (context, i) {
                  return Divider(height: 1, thickness: 2);
                },
                itemCount: model.listNotification.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int i) {
                  return InkWell(
                    onTap: () {
                      model.readNotif(model.listNotification[i].id ?? 0);
                    },
                    child: Card(
                      color: model.listNotification[i].isRead == 0
                          ? MyColors.ColorPrimaryShadow
                          : Colors.transparent,
                      elevation: 0,
                      margin: EdgeInsets.all(0),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(8),
                        isThreeLine: true,
                        leading: Icon(Icons.notifications_active, size: 35),
                        title: Paragraft(
                          text: model.listNotification[i].title ?? '',
                          textStyle: textThinSuperBold,
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Paragraft(
                              text:
                                  model.listNotification[i].createdOnFormated ??
                                  '',
                              textStyle: textThin,
                              color: Colors.black54,
                            ),
                            Paragraft(
                              text: model.listNotification[i].body ?? '',
                              textStyle: textThin,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
