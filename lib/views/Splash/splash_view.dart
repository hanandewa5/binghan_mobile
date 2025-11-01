import 'package:binghan_mobile/viewmodels/splash_viewmodel.dart';
import 'package:binghan_mobile/views/_helpers/ui_helpers.dart';
import 'package:binghan_mobile/views/_widgets/Button/button_submit.dart';
import 'package:binghan_mobile/views/_widgets/Paragraft.dart';
import 'package:binghan_mobile/views/base_view.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;

    return BaseView<SplashViewModel>(
      onModelReady: (model) => model.init(),
      builder: (context, model, child) => Scaffold(
        body: Container(
          height: _size.height,
          width: _size.width,
          color: Color(0xFFFEFEFE),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * 0.3,
                child: Image.asset("lib/_assets/images/logo.png"),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    model.isError
                        ? model.isAnyUpdate
                            ? Column(
                                children: <Widget>[
                                  ButtonSubmit(
                                    onPressed: model.goToAppStore,
                                    title: "Pergi Ke Appstore",
                                  ),
                                  UIHelper.verticalSpace(10),
                                  if (!model.isForce)
                                    InkWell(
                                      onTap: model.goToLogin,
                                      child: Paragraft(
                                        text: "Lain Kali",
                                        color: Colors.black45,
                                      ),
                                    )
                                ],
                              )
                            : IconButton(
                                icon: Icon(
                                  Icons.refresh,
                                  size: 30,
                                ),
                                onPressed: model.init,
                              )
                        : Container(
                            height: 30,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Stack(
                                children: <Widget>[
                                  Container(
                                    height: 10,
                                    width: _size.width * 0.8,
                                    color: Colors.black12,
                                  ),
                                  AnimatedContainer(
                                    duration: Duration(milliseconds: 500),
                                    height: 10,
                                    width: (_size.width * 0.8) * model.persVal,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ],
                              ),
                            ),
                          ),
                    UIHelper.verticalSpace(10),
                    Padding(
                      padding: UIHelper.marginHorizontal(30),
                      child: Paragraft(
                        text: model.checkLabel,
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
