import 'package:binghan_mobile/_services/auth_service.dart';
import 'package:binghan_mobile/_services/dialog_service.dart';
import 'package:binghan_mobile/_config/locator.dart';
import 'package:binghan_mobile/_services/member_service.dart';
import 'package:binghan_mobile/_services/navigation_service.dart';
import 'package:binghan_mobile/models/user.dart';
import 'package:binghan_mobile/viewmodels/_basemodel.dart';
import 'package:binghan_mobile/_constants/route_paths.dart' as routes;
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AuthViewModel extends BaseModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final AuthService _authService = locator<AuthService>();
  final DialogService _dialogService = locator<DialogService>();
  final MemberService _memberService = locator<MemberService>();

  String? errorMessage;
  bool hideTextLogin = true;
  bool hideTextReset = true;
  WebViewController? _controller;

  void init() {
    // firebaseCloudMessagingListeners();
  }

  void modalTermAndCondition(BuildContext context) async {
    // await getStorage('isLogin');
    // _navigationService.navigateTo(routes.WebWelcome);
  }

  Future<void> exitApp(BuildContext context) async {
    if (await _controller?.canGoBack() == true) {
      _controller?.goBack();
    } else {
      _navigationService.replaceTo(routes.AppRoute);
    }
  }

  Future login(String binghanId, String password) async {
    setBusy(true);
    Map<String, dynamic> data = {"binghan_id": binghanId, "password": password};
    var resLogin = await _authService.login(data);
    setBusy(false);

    if (resLogin.code != 200) {
      errorMessage = resLogin.msg;
      await _dialogService.showDialog(title: 'Alert !', descs: errorMessage);
    } else {
      setErrorMessage(null);
      await setStorage("isLogin", true);
      await setStorageString("token", resLogin.data?.token);
      await setStorage("userData", resLogin.data?.me);
      var res = await _memberService.getUser(resLogin.data?.me["id"]);
      if (res.code == 200) {
        _navigationService.replaceTo(routes.AppRoute);
      }
    }
  }

  Future setProcess(String email) async {
    setBusy(true);
    var res = await _authService.forgotPass(email);
    if (res.code != 200) {
      errorMessage = res.msg;
      await _dialogService.showDialog(title: 'Alert !', descs: errorMessage);
    } else {
      setErrorMessage(null);
      await _dialogService.showDialog(
        title: 'Alert !',
        descs: "Your request has been processed",
      );
      _navigationService.goBack();
    }
  }

  void goToForgotPass() {
    _navigationService.navigateTo(routes.ForgotPassRoute);
  }

  void goToWeb(BuildContext context) {
    _navigationService.navigateTo(routes.WebWelcome);
  }

  void goToResetPass() {
    _navigationService.navigateTo(routes.ResetPassRoute);
  }

  void goBack() {
    _navigationService.goBack();
  }

  void setHideLogin() {
    hideTextLogin = !hideTextLogin;
    refresh();
  }

  void setHideReset() {
    hideTextReset = !hideTextReset;
    refresh();
  }

  void initWebview(WebViewController controller) {
    _controller = controller;
  }

  void onPageFinished(String check) {
    _controller?.runJavaScript(
      "document.getElementsByClassName('elementor-element elementor-element-3651b70 elementor-view-default elementor-widget elementor-widget-icon')[0].style.display='none';" +
          "document.getElementsByClassName('elementor-element elementor-element-dd7bdec elementor-widget elementor-widget-heading')[0].style.display='none';",
    );
  }

  Future checkLogin() async {
    setScreenLoad(true);

    bool? isLogin = await getStorage('isLogin');
    if (isLogin != null && isLogin != false) {
      User? userData = User.fromJson(await getStorage("userData"));
      var res = await _memberService.getUser(userData.id ?? 0);
      if (res.code == 200) {
        Future.delayed(Duration(seconds: 1), () {
          _navigationService.replaceTo(routes.AppRoute);
          return false;
        });
      } else {
        setScreenLoad(false);
        return false;
      }
    } else {
      Future.delayed(Duration(seconds: 1), () {
        _navigationService.replaceTo(routes.LoginRoute);
        return false;
      });
    }
  }
}
