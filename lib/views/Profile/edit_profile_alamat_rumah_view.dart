import 'package:binghan_mobile/models/city.dart';
import 'package:binghan_mobile/models/district.dart';
import 'package:binghan_mobile/models/province.dart';
import 'package:binghan_mobile/viewmodels/profile_viewmodal.dart';
import 'package:binghan_mobile/views/_helpers/color_helper.dart';
import 'package:binghan_mobile/views/_helpers/text_helper.dart';
import 'package:binghan_mobile/views/_helpers/ui_helpers.dart';
import 'package:binghan_mobile/views/_widgets/Button/button_submit.dart';
import 'package:binghan_mobile/views/_widgets/Input/input_multi.dart';
import 'package:binghan_mobile/views/_widgets/Input/input_text.dart';
import 'package:find_dropdown/find_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:binghan_mobile/views/base_view.dart';

class EditProfileAlamatRumahView extends StatelessWidget {
  const EditProfileAlamatRumahView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<ProfileViewModel>(
      onModelReady: (model) {
        model.getAlamatRumah();
      },
      statusBarTheme: Brightness.dark,
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(
            centerTitle: true,
            title: Text("Edit Alamat Rumah", style: textMedium),
            elevation: 0,
          ),
          body: Container(
            margin: UIHelper.marginSymmetric(10, 10),
            child: Form(
              key: model.formAlamatRumah,
              child: ListView(
                children: <Widget>[
                  FindDropdown<ListProvince>(
                    onFind: (String filter) {
                      return model.getProvince(filter);
                    },
                    onChanged: (ListProvince? data) {
                      if (data != null) {
                        model.setProvince(data);
                      }
                    },
                    dropdownBuilder:
                        (BuildContext context, ListProvince? data) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      width: 2,
                                      color: model.isProvince
                                          ? Theme.of(context).primaryColor
                                          : Theme.of(context).colorScheme.error,
                                    ),
                                  ),
                                ),
                                alignment: Alignment.centerLeft,
                                child: ListTile(
                                  contentPadding: EdgeInsets.all(0),
                                  trailing: Icon(Icons.arrow_drop_down_circle),
                                  title: Text(
                                    "Provinsi",
                                    style: textSmall.merge(
                                      TextStyle(
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  ),
                                  subtitle: (model.province != null)
                                      ? Text(
                                          model.province?.province ?? '',
                                          style: textMedium.merge(
                                            TextStyle(color: Colors.black),
                                          ),
                                        )
                                      : Text("Pilih Provinsi"),
                                ),
                              ),
                              model.isProvince
                                  ? SizedBox(height: 0)
                                  : Text(
                                      "Provinsi is requred",
                                      style: MyColors.ColorInputError.merge(
                                        textSmall,
                                      ),
                                    ),
                            ],
                          );
                        },
                    dropdownItemBuilder:
                        (BuildContext context, ListProvince data, bool isSel) {
                          return ListTile(
                            leading: Icon(Icons.search),
                            title: Text(data.province ?? ''),
                          );
                        },
                  ),
                  FindDropdown<ListCity>(
                    onFind: (String filter) {
                      return model.getCity(filter);
                    },
                    onChanged: (ListCity? data) {
                      if (data != null) {
                        model.setCity(data);
                      }
                    },
                    dropdownBuilder: (BuildContext context, ListCity? data) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  width: 2,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                            alignment: Alignment.centerLeft,
                            child: ListTile(
                              contentPadding: EdgeInsets.all(0),
                              trailing: Icon(Icons.arrow_drop_down_circle),
                              title: Text(
                                "Kota",
                                style: textSmall.merge(
                                  TextStyle(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ),
                              subtitle: (model.city != null)
                                  ? Text(
                                      model.city!.cityName!,
                                      style: textMedium.merge(
                                        TextStyle(color: Colors.black),
                                      ),
                                    )
                                  : Text("Pilih Kota"),
                            ),
                          ),
                          model.isCity
                              ? SizedBox(height: 0)
                              : Text(
                                  "Provinsi is requred",
                                  style: MyColors.ColorInputError.merge(
                                    textSmall,
                                  ),
                                ),
                        ],
                      );
                    },
                    dropdownItemBuilder:
                        (BuildContext context, ListCity data, bool isSel) {
                          return ListTile(
                            leading: Icon(Icons.search),
                            title: Text(data.cityName ?? ''),
                          );
                        },
                  ),
                  FindDropdown<ListDistrict>(
                    onFind: (String filter) {
                      return model.getDistrict(filter);
                    },
                    onChanged: (ListDistrict? data) {
                      if (data != null) {
                        model.setDistrict(data);
                      }
                    },
                    dropdownBuilder:
                        (BuildContext context, ListDistrict? data) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      width: 2,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ),
                                alignment: Alignment.centerLeft,
                                child: ListTile(
                                  contentPadding: EdgeInsets.all(0),
                                  trailing: Icon(Icons.arrow_drop_down_circle),
                                  title: Text(
                                    "Kecamatan",
                                    style: textSmall.merge(
                                      TextStyle(
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  ),
                                  subtitle: (model.district != null)
                                      ? Text(
                                          model.district!.subdistrictName ?? '',
                                          style: textMedium.merge(
                                            TextStyle(color: Colors.black),
                                          ),
                                        )
                                      : Text("Pilih Kecamatan"),
                                ),
                              ),
                              model.isDistrict
                                  ? SizedBox(height: 0)
                                  : Text(
                                      "Provinsi is requred",
                                      style: MyColors.ColorInputError.merge(
                                        textSmall,
                                      ),
                                    ),
                            ],
                          );
                        },
                    dropdownItemBuilder:
                        (BuildContext context, ListDistrict data, bool isSel) {
                          return Container(
                            child: ListTile(
                              leading: Icon(Icons.search),
                              title: Text(data.subdistrictName ?? ''),
                            ),
                          );
                        },
                  ),
                  InputText(
                    bordered: true,
                    isRequered: true,
                    name: "Kelurahan",
                    controller: model.kelurahan,
                  ),
                  InputMulti(
                    name: "Full Address",
                    isRequered: true,
                    bordered: true,
                    controller: model.fullAddress,
                  ),
                  InputText(
                    bordered: true,
                    isRequered: true,
                    name: "Kode Pos",
                    controller: model.kdPost,
                  ),
                  UIHelper.verticalSpaceMedium(),
                  ButtonSubmit(title: "Save", onPressed: model.saveAlamatRumah),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
