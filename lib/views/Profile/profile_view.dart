import 'package:binghan_mobile/viewmodels/profile_viewmodal.dart';
import 'package:binghan_mobile/views/_helpers/color_helper.dart';
import 'package:binghan_mobile/views/_helpers/text_helper.dart';
import 'package:binghan_mobile/views/_helpers/ui_helpers.dart';
import 'package:binghan_mobile/views/_widgets/Layout/picture_loader.dart';
import 'package:binghan_mobile/views/_widgets/Layout/profile_tile.dart';
import 'package:flutter/material.dart';
import 'package:binghan_mobile/views/base_view.dart';

class Profile extends StatefulWidget {
  const Profile({super.key}) ;

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    // var _width = MediaQuery.of(context).size.width;
    // var _height = MediaQuery.of(context).size.height;
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
                actions: <Widget>[
                  InkWell(
                    onTap: model.goToEditProfileList,
                    child: Icon(Icons.settings),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
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
                                isBusy: false,
                                url: model.userData.photoUrl,
                              ),
                              UIHelper.verticalSpaceMedium(),
                              Text(
                                "${model.userData.firstName} ${model.userData.lastName}",
                                style: textLarge,
                              ),
                              Text(
                                "${model.userData.binghanId}",
                                style: textThin,
                              ),
                              Text(
                                "Level : ${model.userData.memberClass}",
                                style:
                                    textMedium.merge(MyColors.ColorInputAccent),
                              ),
                              UIHelper.verticalSpaceSmall(),
                              Text(
                                "Your membership will be expired on ${model.userData.memberExpiryFormated}",
                                textAlign: TextAlign.center,
                                style: textThin.merge(MyColors.ColorInputGrey),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                          margin: UIHelper.marginHorizontal(18),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              ProfileTile(
                                title: "Syarat PV untuk perpanjang",
                                value: model.renewalPV == 0
                                    ? "Sudah Tercapai"
                                    : "${model.renewalPV}" + " PV",
                              ),
                              ProfileTile(
                                title: "ID Sponsor",
                                value: model.userData.sponsorBinghanId,
                              ),
                              ProfileTile(
                                title: "Nama Sponsor",
                                value: model.userData.namaSponsor,
                              ),
                              ProfileTile(
                                title: "ID Diamond Managing",
                                value: "${model.userData.distributorManagerId}",
                              ),
                              ProfileTile(
                                title: "Nama Diamond Managing",
                                value: model.userData.distributorManager,
                              ),
                            ],
                          ))
                    ],
                  ),
                ),
              ));
        });
  }
}
