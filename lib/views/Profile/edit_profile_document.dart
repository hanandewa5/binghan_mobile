import 'package:flutter/material.dart';

import '../../viewmodels/profile_viewmodal.dart';
import '../_helpers/text_helper.dart';
import '../_helpers/ui_helpers.dart';
import '../_widgets/Button/button_submit.dart';
import '../base_view.dart';
import 'package:binghan_mobile/views/_helpers/color_helper.dart';

class EditProfileDocumentView extends StatelessWidget {
  const EditProfileDocumentView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<ProfileViewModel>(
      onModelReady: (model) {
        model.getDocument();
      },
      statusBarTheme: Brightness.dark,
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(
            centerTitle: true,
            title: Text("Edit Docoment", style: textMedium),
            elevation: 0,
          ),
          body: Container(
            margin: UIHelper.marginSymmetric(10, 10),
            child: Form(
              key: model.formPassword,
              child: ListView(
                children: <Widget>[
                  Text(
                    "Upload Photo KTP",
                    style: textLarge.merge(MyColors.ColorInputBlack),
                  ),
                  Center(
                    child: InkWell(
                      onTap: () {
                        model.pictPhotoDoc("KTP");
                      },
                      child: Container(
                        width: 300,
                        height: 200,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ClipRRect(
                          borderRadius: new BorderRadius.circular(8.0),
                          child: FadeInImage(
                            fit: BoxFit.cover,
                            placeholder: AssetImage(
                              "assets/images/loading.gif",
                            ),
                            image: model.busy
                                ? AssetImage("assets/images/loading.gif")
                                : (model.fotoKTpFile != null)
                                ? FileImage(model.fotoKTpFile!)
                                : (model.fotoKTpUrl != "" &&
                                      model.fotoKTpUrl != null &&
                                      model.fotoKTpUrl != "null")
                                ? NetworkImage(
                                    "${model.fotoKTpUrl}?${DateTime.now()}",
                                  )
                                : AssetImage("assets/images/ktp.png"),
                          ),
                        ),
                      ),
                    ),
                  ),
                  UIHelper.verticalSpaceMedium(),
                  model.npwp.text == ""
                      ? Text("")
                      : Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Upload Photo NPWP",
                                style: textLarge.merge(
                                  MyColors.ColorInputBlack,
                                ),
                              ),
                              Center(
                                child: InkWell(
                                  onTap: () {
                                    model.pictPhotoDoc("NPWP");
                                  },
                                  child: Container(
                                    width: 300,
                                    height: 200,
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: new BorderRadius.circular(
                                        8.0,
                                      ),
                                      child: FadeInImage(
                                        fit: BoxFit.cover,
                                        placeholder: AssetImage(
                                          "assets/images/loading.gif",
                                        ),
                                        image: model.busy
                                            ? AssetImage(
                                                "assets/images/loading.gif",
                                              )
                                            : (model.fotoNPWPFile != null)
                                            ? FileImage(model.fotoNPWPFile!)
                                            : (model.fotoNPWPUrl != "" &&
                                                  model.fotoNPWPUrl != null &&
                                                  model.fotoNPWPUrl != "null")
                                            ? NetworkImage(
                                                "${model.fotoNPWPUrl}?${DateTime.now()}",
                                              )
                                            : AssetImage(
                                                "assets/images/ktp.png",
                                              ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                  UIHelper.verticalSpaceMedium(),
                  ButtonSubmit(
                    isLoad: model.busy,
                    title: "Save",
                    onPressed: model.saveDocument,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
