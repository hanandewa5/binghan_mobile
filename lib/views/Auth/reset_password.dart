import 'package:binghan_mobile/views/_helpers/color_helper.dart';
import 'package:binghan_mobile/views/_helpers/text_helper.dart';
import 'package:binghan_mobile/views/_helpers/ui_helpers.dart';
import 'package:binghan_mobile/views/_widgets/Input/input_password.dart';
import 'package:binghan_mobile/views/_widgets/Layout/card_form.dart';
import 'package:binghan_mobile/views/_widgets/Layout/content.dart';
import 'package:binghan_mobile/views/_widgets/RaisedGradientButton.dart';
import 'package:flutter/material.dart';
import 'package:binghan_mobile/viewmodels/auth_viewmodel.dart';
import 'package:binghan_mobile/views/base_view.dart';

class ResetPass extends StatefulWidget {
  const ResetPass({super.key});

  @override
  State<ResetPass> createState() => _ResetPassState();
}

class _ResetPassState extends State<ResetPass> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BaseView<AuthViewModel>(
      onModelReady: (model) {
        model.checkLogin();
      },
      statusBarTheme: Brightness.light,
      builder: (context, model, child) => Scaffold(
        backgroundColor: MyColors.ColorBackground,
        body: Content(child: buildContainer(model, context)),
      ),
    );
  }

  Container buildContainer(AuthViewModel model, BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Flexible(
            flex: 1,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: Image.asset("lib/_assets/images/logo.png"),
                  ),
                  Text("Reset Password", style: headerStyle),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Center(
              child: CardForm(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          InputPassword(name: "New Password"),
                          InputPassword(name: "Confirm Password"),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          RaisedGradientButton(
                            child: Text("Process", style: btnTextWhite),
                            width: MediaQuery.of(context).size.width * 0.83,
                            onPressed: () {
                              // model.setProcess();
                            },
                            gradient: LinearGradient(
                              colors: <Color>[
                                Color(0xFFBEA236),
                                Color(0xFFBEA236),
                              ],
                            ),
                          ),
                          UIHelper.verticalSpaceSmall(),
                          RaisedGradientButton(
                            child: Text("Cancel", style: btnTextWhite),
                            width: MediaQuery.of(context).size.width * 0.83,
                            onPressed: () {
                              model.goBack();
                            },
                            gradient: LinearGradient(
                              colors: <Color>[
                                Colors.redAccent,
                                Colors.redAccent,
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
