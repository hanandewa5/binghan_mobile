import 'package:binghan_mobile/viewmodels/profile_viewmodal.dart';
import 'package:binghan_mobile/views/_helpers/text_helper.dart';
import 'package:binghan_mobile/views/_helpers/ui_helpers.dart';
import 'package:binghan_mobile/views/_widgets/Button/button_submit.dart';
import 'package:binghan_mobile/views/_widgets/Input/input_auto.dart';
import 'package:binghan_mobile/views/_widgets/Input/input_text.dart';
import 'package:flutter/material.dart';
import 'package:binghan_mobile/views/base_view.dart';

class EditProfileBiodataView extends StatelessWidget {
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
                  "Edit Biodata",
                  style: textMedium,
                ),
                elevation: 0,
              ),
              body: Container(
                margin: UIHelper.marginSymmetric(10, 10),
                child: Form(
                  key: model.formBiodata,
                  child: ListView(
                    children: <Widget>[
                      InputText(
                        bordered: true,
                        isRequered: true,
                        name: "Nama Depan",
                        controller: model.firstName,
                      ),
                      InputText(
                        bordered: true,
                        isRequered: true,
                        name: "Nama Belakang",
                        controller: model.lastName,
                      ),
                      InputAuto(
                        name: "Jenis Kelamin",
                        value: model.gender,
                        isExpanded: true,
                        list: <String>["Laki-Laki", "Perempuan"],
                        onChange: model.setJenisKelamin,
                      ),
                      InputText(
                        bordered: true,
                        isRequered: true,
                        textInputType: TextInputType.datetime,
                        placeholder: "example : dd/mm/yyyy",
                        name: "Tanggal Lahir",
                        controller: model.dateBirth,
                      ),
                      InputText(
                        bordered: true,
                        isRequered: true,
                        name: 'No KTP',
                        max: 16,
                        textInputType: TextInputType.number,
                        controller: model.noKtp,
                      ),
                      InputText(
                        bordered: true,
                        name: "NPWP",
                        textInputType: TextInputType.number,
                        controller: model.npwp,
                      ),
                      InputText(
                        bordered: true,
                        name: "Email",
                        isRequered: true,
                        textInputType: TextInputType.emailAddress,
                        controller: model.email,
                      ),
                      InputText(
                        bordered: true,
                        name: "No Handphone",
                        placeholder: "example : 0895123456",
                        textInputType: TextInputType.phone,
                        controller: model.noHp,
                      ),
                      UIHelper.verticalSpaceMedium(),
                      ButtonSubmit(
                        title: "Save",
                        onPressed: model.saveBiodata,
                      )
                    ],
                  ),
                ),
              ));
        });
  }
}
