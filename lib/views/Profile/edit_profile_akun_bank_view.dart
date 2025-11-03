import 'package:binghan_mobile/viewmodels/profile_viewmodal.dart';
import 'package:binghan_mobile/views/_helpers/text_helper.dart';
import 'package:binghan_mobile/views/_helpers/ui_helpers.dart';
import 'package:binghan_mobile/views/_widgets/Button/button_submit.dart';
import 'package:binghan_mobile/views/_widgets/Input/input_text.dart';
import 'package:flutter/material.dart';
import 'package:binghan_mobile/views/base_view.dart';

class EditProfileAkunBankView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<ProfileViewModel>(
        onModelReady: (model) {
          model.getAkunBank();
        },
        statusBarTheme: Brightness.dark,
        builder: (context, model, child) {
          return Scaffold(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              appBar: AppBar(
                centerTitle: true,
                title: Text(
                  "Edit Akun Bank",
                  style: textMedium,
                ),
                elevation: 0,
              ),
              body: Container(
                margin: UIHelper.marginSymmetric(10, 10),
                child: Form(
                  key: model.formAkunBank,
                  child: ListView(
                    children: <Widget>[
                      InputText(
                        bordered: true,
                        isRequered: true,
                        name: "Nama Pemilik Rekening",
                        controller: model.nmPemilikRekening,
                      ),
                      InputText(
                        bordered: true,
                        isRequered: true,
                        name: "Nomor Rekening",
                        controller: model.noRekening,
                        textInputType: TextInputType.number,
                      ),
                      InputText(
                        bordered: true,
                        name: "Cabang",
                        controller: model.cabang,
                      ),
                      InputText(
                        bordered: true,
                        isRequered: true,
                        name: "Nama Bank",
                        controller: model.nmBank,
                      ),
                      UIHelper.verticalSpaceMedium(),
                      ButtonSubmit(
                        title: "Save",
                        onPressed: model.saveAkunBank,
                      )
                    ],
                  ),
                ),
              ));
        });
  }
}
