import 'package:binghan_mobile/views/_helpers/color_helper.dart';
import 'package:binghan_mobile/views/_helpers/text_helper.dart';
import 'package:binghan_mobile/views/_helpers/ui_helpers.dart';
import 'package:binghan_mobile/views/_widgets/Input/input_password.dart';
import 'package:binghan_mobile/views/_widgets/Input/input_text.dart';
import 'package:binghan_mobile/views/_widgets/Layout/card_form.dart';
import 'package:binghan_mobile/views/_widgets/Layout/content.dart';
import 'package:binghan_mobile/views/_widgets/Paragraft.dart';
import 'package:binghan_mobile/views/_widgets/RaisedGradientButton.dart';
import 'package:binghan_mobile/views/_widgets/splash.dart';
import 'package:flutter/material.dart';
import 'package:binghan_mobile/viewmodels/auth_viewmodel.dart';
import 'package:binghan_mobile/views/base_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _binghanId = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BaseView<AuthViewModel>(
      onModelReady: (model) {
        // model.checkLogin();
        model.init();
        model.modalTermAndCondition(context);
      },
      statusBarTheme: Brightness.light,
      builder: (context, model, child) => Scaffold(
        backgroundColor: MyColors.ColorBackground,
        body: Content(
          child: model.screenLoading
              ? Splash()
              : buildContainer(model, context),
        ),
      ),
    );
  }

  Container buildContainer(AuthViewModel model, BuildContext context) {
    return Container(
      child: ListView(
        children: <Widget>[
          UIHelper.verticalSpaceMedium(),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * 0.3,
                child: Image.asset("assets/images/logo.png"),
              ),
              UIHelper.verticalSpaceLarge(),
              Text("Login", style: headerStyle),
            ],
          ),
          CardForm(
            child: Form(
              key: _formKey,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        InputText(name: "Username", controller: _binghanId),
                        UIHelper.verticalSpaceMedium(),
                        InputPassword(controller: _password, name: "Password"),
                        UIHelper.verticalSpaceMedium(),
                      ],
                    ),
                    RaisedGradientButton(
                      child: Container(
                        child: model.busy
                            ? CircularProgressIndicator(
                                backgroundColor: MyColors.ColorPrimary,
                              )
                            : Text("Login", style: btnTextWhite),
                      ),
                      width: MediaQuery.of(context).size.width * 0.83,
                      onPressed: model.busy
                          ? null
                          : () {
                              if (_formKey.currentState!.validate()) {
                                model.login(_binghanId.text, _password.text);
                              }
                            },
                      gradient: LinearGradient(
                        colors: <Color>[Color(0xFFBEA236), Color(0xFFBEA236)],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: 20),
                        InkWell(
                          child: Text(
                            "Back to Homepage",
                            style: textSmallWhite,
                          ),
                          onTap: () {
                            model.goToWeb(context);
                          },
                        ),
                        UIHelper.verticalSpaceMedium(),
                        InkWell(
                          child: Text(
                            "Forgot Password ? ",
                            style: textMediumWhite,
                          ),
                          onTap: () {
                            model.goToForgotPass();
                          },
                        ),
                        // InkWell(
                        //   child: Text(
                        //     "Reset",
                        //     style: textMediumWhite,
                        //   ),
                        //   onTap: () {
                        //     model.goToResetPass();
                        //   },
                        // )
                      ],
                    ),
                    UIHelper.verticalSpaceMedium(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Paragraft(
                          text: "Kontak Layanan Pengaduan Konsumen",
                          color: Colors.white,
                          fontSize: 14,
                        ),
                        Paragraft(
                          text: "PT HONG RUI",
                          color: Colors.white,
                          fontSize: 14,
                        ),
                        Paragraft(
                          text: "Kontak : (021) 260 808 99",
                          color: Colors.white,
                          fontSize: 12,
                        ),
                        Paragraft(
                          text: "Email : hongrui@binghan.id",
                          color: Colors.white,
                          fontSize: 12,
                        ),
                        Paragraft(
                          text:
                              "Direktorat Jenderal Perlindungan Konsumen dan Tertib Niaga",
                          color: Colors.white,
                          fontSize: 12,
                        ),
                        Paragraft(
                          text: "Kementerian Perdagangan Republik Indonesia",
                          color: Colors.white,
                          fontSize: 12,
                        ),
                        Paragraft(
                          text: "Whatsapp : 0853 1111 1010",
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
