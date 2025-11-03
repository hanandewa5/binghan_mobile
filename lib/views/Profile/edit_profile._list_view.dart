import 'package:binghan_mobile/viewmodels/profile_viewmodal.dart';
import 'package:binghan_mobile/views/_helpers/text_helper.dart';
import 'package:binghan_mobile/views/_helpers/ui_helpers.dart';
import 'package:binghan_mobile/views/_widgets/Layout/picture_loader.dart';
import 'package:binghan_mobile/views/_widgets/Paragraft.dart';
import 'package:flutter/material.dart';
import 'package:binghan_mobile/views/base_view.dart';
import 'package:binghan_mobile/_constants/route_paths.dart' as routes;

class EditProfileList extends StatefulWidget {
  const EditProfileList({super.key}) ;

  @override
  _EditProfileListState createState() => _EditProfileListState();
}

class _EditProfileListState extends State<EditProfileList> {
  @override
  Widget build(BuildContext context) {
    // var _width = MediaQuery.of(context).size.width;
    // var _height = MediaQuery.of(context).size.height;

    List<Map<String, dynamic>> listEditProfile = [
      {"name": "Edit Biodata", "route": routes.EditProfileBioDataRoute},
      {"name": "Edit Alamat Rumah", "route": routes.EditProfileAlamatRumahRoute},
      {"name": "Edit Alamat Kantor", "route": routes.EditProfileAlamatKantorRoute},
      {"name": "Edit Akun Bank", "route": routes.EditProfileAkunBankRoute},
      {"name": "Edit Document", "route": routes.EditDocumentRoute},
      {"name": "Edit Password", "route": routes.EditPasswordRoute},
      {"name": "Logout", "route": "logout"}
    ];

    return BaseView<ProfileViewModel>(
        onModelReady: (model) {
          model.getUserData();
        },
        statusBarTheme: Brightness.dark,
        builder: (context, model, child) {
          return Scaffold(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              appBar: AppBar(
                centerTitle: true,
                title: Text(MyStrings.textProfile),
                elevation: 0,
              ),
              body: RefreshIndicator(
                onRefresh: model.refreshInit,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: UIHelper.marginHorizontal(18),
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              UIHelper.verticalSpaceMedium(),
                              PictureLoader(
                                width: 100,
                                height: 100,
                                isBusy: model.busy,
                                editable: true,
                                onPressed: model.pictPhoto,
                                url: model.userData.photoUrl,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.only(top: 30),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: listEditProfile.length,
                            itemBuilder: (context, i) {
                              return InkWell(
                                onTap: () {
                                  model.goToEditProfile(listEditProfile[i]["route"]);
                                },
                                child: Column(
                                  children: <Widget>[
                                    ListTile(
                                      title: Paragraft(
                                        text: listEditProfile[i]["name"],
                                        color: listEditProfile[i]["name"] == "Logout"
                                            ? Colors.redAccent
                                            : null,
                                      ),
                                      trailing: Icon(Icons.arrow_forward),
                                    ),
                                    Divider(
                                      height: 1,
                                      thickness: 1,
                                    )
                                  ],
                                ),
                              );
                            },
                          ))
                    ],
                  ),
                ),
              ));
        });
  }
}
