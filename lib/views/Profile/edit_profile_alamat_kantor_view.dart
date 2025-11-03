import 'package:binghan_mobile/viewmodels/profile_viewmodal.dart';
import 'package:binghan_mobile/views/_helpers/text_helper.dart';
import 'package:binghan_mobile/views/_helpers/ui_helpers.dart';
import 'package:binghan_mobile/views/_widgets/Button/button_submit.dart';
import 'package:binghan_mobile/views/_widgets/Input/input_text.dart';
import 'package:flutter/material.dart';
import 'package:binghan_mobile/views/base_view.dart';

class EditProfileAlamatKantorView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<ProfileViewModel>(
        onModelReady: (model) {
          model.getAlamatKantor();
        },
        statusBarTheme: Brightness.dark,
        builder: (context, model, child) {
          return Scaffold(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              appBar: AppBar(
                centerTitle: true,
                title: Text(
                  "Edit Alamat Kantor",
                  style: textMedium,
                ),
                elevation: 0,
              ),
              body: Container(
                margin: UIHelper.marginSymmetric(10, 10),
                child: Form(
                  key: model.formAlamatKantor,
                  child: ListView(
                    children: <Widget>[
                      InputText(
                        bordered: true,
                        name: "Office Address",
                        controller: model.officeAddress,
                      ),
                      UIHelper.verticalSpaceMedium(),
                      ButtonSubmit(
                        title: "Save",
                        onPressed: model.saveAlamatKantor,
                      )
                    ],
                  ),
                ),
              ));
        });
  }
}
