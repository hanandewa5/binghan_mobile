import 'package:flutter/material.dart';

import '../../viewmodels/profile_viewmodal.dart';
import '../_helpers/text_helper.dart';
import '../_helpers/ui_helpers.dart';
import '../_widgets/Button/button_submit.dart';
import '../_widgets/Input/input_password.dart';
import '../_widgets/Input/input_text.dart';
import '../base_view.dart';

class EditProfilePasswordView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<ProfileViewModel>(
        onModelReady: (model) {
          model.getBiodata();
        },
        statusBarTheme: Brightness.dark,
        builder: (context, model, child) {
          return Scaffold(
              backgroundColor: Theme.of(context).backgroundColor,
              appBar: AppBar(
                centerTitle: true,
                title: Text(
                  "Edit Password",
                  style: textMedium,
                ),
                elevation: 0,
              ),
              body: Container(
                margin: UIHelper.marginSymmetric(10, 10),
                child: Form(
                  key: model.formPassword,
                  child: ListView(
                    children: <Widget>[
                      InputText(
                        bordered: true,
                        isRequered: true,
                        obscureText: true,
                        name: "Password Lama",
                        controller: model.oldPass,
                      ),
                      InputText(
                        bordered: true,
                        isRequered: true,
                        obscureText: true,
                        name: "Password Baru",
                        controller: model.newPass,
                      ),
                      InputText(
                        bordered: true,
                        isRequered: true,
                        obscureText: true,
                        name: "Confirm Password Baru",
                        controller: model.conNewPass,
                      ),
                      UIHelper.verticalSpaceMedium(),
                      ButtonSubmit(
                        title: "Save",
                        isLoad: model.busy,
                        onPressed: model.savePassword,
                      )
                    ],
                  ),
                ),
              ));
        });
  }
}
