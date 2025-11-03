import 'package:binghan_mobile/viewmodels/auth_viewmodel.dart';
import 'package:binghan_mobile/views/_widgets/Paragraft.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../base_view.dart';

class WebWelcome extends StatelessWidget {
  const WebWelcome({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<AuthViewModel>(
      statusBarTheme: Brightness.dark,
      builder: (context, model, child) {
        return WillPopScope(
          onWillPop: () => model.exitApp(context),
          child: Scaffold(
            appBar: AppBar(
              leading: SizedBox(),
              actions: [
                InkWell(
                  onTap: model.checkLogin,
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Paragraft(text: "Login", color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
            backgroundColor: Colors.white,
            body: WebViewWidget(
              controller: WebViewController()
                ..setJavaScriptMode(JavaScriptMode.unrestricted)
                ..loadRequest(Uri.parse("https://binghan.id")),

              // onWebViewCreated: model.initWebview,
              // onPageFinished: model.onPageFinished,
            ),
          ),
        );
      },
    );
  }
}
