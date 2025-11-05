import 'dart:io';

import 'package:binghan_mobile/_config/locator.dart';
import 'package:binghan_mobile/_constants/app_config.dart';
import 'package:binghan_mobile/_services/navigation_service.dart';
import 'package:binghan_mobile/_services/splash_service.dart';
import 'package:binghan_mobile/viewmodels/_basemodel.dart';
import 'package:binghan_mobile/_constants/route_paths.dart' as routes;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SplashViewModel extends BaseModel {
  final NavigationService _navServ = locator<NavigationService>();
  final SplashService _splashServ = locator<SplashService>();

  double persVal = 0.0;
  String checkLabel = "";
  bool isError = false;
  bool isAnyUpdate = false;
  bool isForce = false;

  Future init() async {
    checkLabel = "Initialization";
    await Future.delayed(Duration(seconds: 1));
    persVal += 0.25;
    refresh();
    checkConnection();
    // await _navServ.navigateTo(routes.LoginRoute);
  }

  Future checkConnection() async {
    checkLabel = "Check Koneksi";
    var res = await _splashServ.checkConnection();
    if (res.code == 200) {
      Future.delayed(Duration(milliseconds: 500), () {
        persVal += 0.25;
        refresh();
        checkVersion();
      });
    } else {
      errorHandle("Maaf ada kesalahan... coba lagi!");
    }
  }

  Future checkVersion() async {
    checkLabel = "Check Version";
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String appVersion = packageInfo.buildNumber;
    // var res = await _splashServ.checkVersion(appVersion);

    Future.delayed(Duration(milliseconds: 300), () {
      persVal += 0.25;
      refresh();
      _navServ.replaceTo(routes.WebWelcome);
    });

    // if (res.code == 200) {
    //   if (res.data["is_update"]) {
    //     errorHandle(
    //       "Versi aplikasi anda belum update, silahkan update di Play Store!",
    //       isUpdate: true,
    //       isForced: res.data["is_force"],
    //     );
    //   } else {
    //     Future.delayed(Duration(milliseconds: 300), () {
    //       persVal += 0.25;
    //       refresh();
    //       _navServ.replaceTo(routes.WebWelcome);
    //     });
    //   }

    //   Future.delayed(Duration(milliseconds: 300), () {
    //     persVal += 0.25;
    //     refresh();
    //     _navServ.replaceTo(routes.WebWelcome);
    //   });
    // } else {
    //   errorHandle("Maaf ada kesalahan... coba lagi!");
    // }
  }

  Future goToAppStore() async {
    var url = Platform.isAndroid
        ? AppConfig.playStoreUrl
        : AppConfig.appStoreUrl;
    PackageInfo info = await PackageInfo.fromPlatform();
    var marketUrl = "market://details?id=${info.packageName}";

    if (await canLaunchUrlString(marketUrl)) {
      await launchUrlString(marketUrl);
    } else {
      await launchUrlString(url);
    }
  }

  void errorHandle(
    String label, {
    bool isUpdate = false,
    bool isForced = false,
  }) async {
    checkLabel = label;
    isError = true;
    isAnyUpdate = isUpdate;
    isForce = isForced;
    refresh();
  }

  Future goToLogin() async {
    await _navServ.replaceTo(routes.LoginRoute);
  }
}
