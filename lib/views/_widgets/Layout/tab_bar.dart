import 'package:binghan_mobile/_config/locator.dart';
import 'package:binghan_mobile/viewmodels/dashboard_viewmodel.dart';
import 'package:binghan_mobile/viewmodels/member_viewmodel.dart';
import 'package:binghan_mobile/views/Dashboard/dashboard_view.dart';
import 'package:binghan_mobile/views/Member/group_sales_view.dart';
import 'package:binghan_mobile/views/Order/order_history_tab.dart';
import 'package:binghan_mobile/views/Product/product_view.dart';
import 'package:binghan_mobile/views/Profile/profile_view.dart';
import 'package:binghan_mobile/views/_helpers/icon_helper.dart';
import 'package:binghan_mobile/views/_helpers/text_helper.dart';
// import 'package:binghan_mobile/views/_widgets/Alert/Toast.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) async {
  if (message.containsKey('data')) {
    final dynamic data = message['data'];
    print(data);
  }

  if (message.containsKey('notification')) {
    final dynamic notification = message['notification'];
    print(notification);
  }
  return Future<void>.value();
}

class AppTabBar extends StatefulWidget {
  const AppTabBar({super.key});

  @override
  State<AppTabBar> createState() => _AppTabBarState();
}

class _AppTabBarState extends State<AppTabBar>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  DateTime? currentBackPressTime;
  // final _firebaseMessaging = FirebaseMessaging.instance;
  final _dashboardViewModel = locator<DashboardViewModel>();

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 5, vsync: this);
    _controller.addListener(_handleTabSelection);
    // firebaseCloudMessagingListeners();
  }

  void _handleTabSelection() {
    setState(() {});
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null &&
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
        msg: "Tekan sekali lagi untuk keluar aplikasi",
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return Future.value(false);
    }
    return Future.value(true);
  }

  void firebaseCloudMessagingListeners() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      Fluttertoast.showToast(
        msg: message.data["notification"]["body"],
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black38,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      await _dashboardViewModel.getNotification();
    });

    FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    FirebaseMessaging.instance.getToken().then((token) {
      MemberViewModel _model = locator<MemberViewModel>();
      if (token != null) {
        _model.editMember(token);
      }
      print(token);
    });
  }

  @override
  Widget build(BuildContext context) {
    var colorBackground = Theme.of(context).scaffoldBackgroundColor;
    var colorButtonActive = Theme.of(context).colorScheme.secondary;
    return Scaffold(
      body: WillPopScope(
        onWillPop: onWillPop,
        child: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          controller: _controller,
          children: <Widget>[
            DashboardView(),
            // OrderHistoryView(),
            OrderHistoryTabView(),
            Product(),
            GroupSalesView(),
            Profile(),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: colorBackground,
          boxShadow: [
            BoxShadow(color: Colors.grey, blurRadius: 8.0, spreadRadius: 1.0),
          ],
        ),
        child: TabBar(
          indicatorWeight: 1,
          labelStyle: TextStyle(fontSize: 13),
          labelColor: colorButtonActive,
          unselectedLabelColor: Colors.black87,
          controller: _controller,
          labelPadding: EdgeInsets.all(0),
          tabs: <Widget>[
            Tab(
              icon: (_controller.index == 0)
                  ? SvgPicture.asset(MyIcon.home_active)
                  : SvgPicture.asset(MyIcon.home_inactive),
              text: MyStrings.textHome,
            ),
            Tab(
              icon: (_controller.index == 1)
                  ? SvgPicture.asset(MyIcon.history_active)
                  : SvgPicture.asset(MyIcon.history_inactive),
              text: MyStrings.textOrderHistory,
            ),
            Tab(
              icon: (_controller.index == 2)
                  ? SvgPicture.asset(MyIcon.product_active)
                  : SvgPicture.asset(MyIcon.product_inactive),
              text: MyStrings.textProduct,
            ),
            Tab(
              icon: (_controller.index == 3)
                  ? Icon(Icons.people)
                  : Icon(Icons.people_outline, color: colorButtonActive),
              text: MyStrings.textNetwork,
            ),
            Tab(
              icon: (_controller.index == 4)
                  ? SvgPicture.asset(MyIcon.profile_active)
                  : SvgPicture.asset(MyIcon.profile_inactive),
              text: MyStrings.textProfile,
            ),
          ],
        ),
      ),
    );
  }
}
