import 'package:binghan_mobile/views/_helpers/color_helper.dart';
import 'package:binghan_mobile/views/_helpers/text_helper.dart';
import 'package:binghan_mobile/views/_helpers/ui_helpers.dart';
import 'package:binghan_mobile/views/_widgets/Input/input_text.dart';
import 'package:binghan_mobile/views/_widgets/Layout/card_form.dart';
import 'package:binghan_mobile/views/_widgets/Layout/content.dart';
import 'package:binghan_mobile/views/_widgets/RaisedGradientButton.dart';
import 'package:flutter/material.dart';
import 'package:binghan_mobile/viewmodels/auth_viewmodel.dart';
import 'package:binghan_mobile/views/base_view.dart';

class ForgotPass extends StatefulWidget {
  const ForgotPass({super.key}) ;

  @override
  _ForgotPassState createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseView<AuthViewModel>(
      statusBarTheme: Brightness.light,
      builder: (context, model, child) => Scaffold(
          backgroundColor: MyColors.ColorBackground,
          body: Content(
            child: buildContainer(model, context),
          )),
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
                Text(
                  "Forgot Password",
                  style: headerStyle,
                )
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
                    InputText(
                      name: "Email",
                      controller: _email,
                    ),
                    Column(
                      children: <Widget>[
                        RaisedGradientButton(
                          child: Text(
                            "Process",
                            style: btnTextWhite,
                          ),
                          width: MediaQuery.of(context).size.width * 0.83,
                          onPressed: () {
                            model.setProcess(_email.text);
                          },
                          gradient: LinearGradient(
                            colors: <Color>[Color(0xFFBEA236), Color(0xFFBEA236)],
                          ),
                        ),
                        UIHelper.verticalSpaceSmall(),
                        RaisedGradientButton(
                          child: Text(
                            "Cancel",
                            style: btnTextWhite,
                          ),
                          width: MediaQuery.of(context).size.width * 0.83,
                          onPressed: () {
                            model.goBack();
                          },
                          gradient: LinearGradient(
                            colors: <Color>[Colors.redAccent, Colors.redAccent],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
