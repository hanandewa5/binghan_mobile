import 'package:binghan_mobile/models/city.dart';
import 'package:binghan_mobile/models/district.dart';
import 'package:binghan_mobile/models/province.dart';
import 'package:binghan_mobile/views/_helpers/color_helper.dart';
import 'package:binghan_mobile/views/_helpers/text_helper.dart';
import 'package:binghan_mobile/viewmodels/member_viewmodel.dart';
import 'package:binghan_mobile/views/_helpers/ui_helpers.dart';
import 'package:binghan_mobile/views/_widgets/Input/input_auto.dart';
import 'package:binghan_mobile/views/_widgets/Input/input_date.dart';
import 'package:binghan_mobile/views/_widgets/Input/input_multi.dart';
import 'package:binghan_mobile/views/_widgets/Input/input_text.dart';
import 'package:binghan_mobile/views/_widgets/Layout/bank_child.dart';
import 'package:find_dropdown/find_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:binghan_mobile/views/base_view.dart';

class NewMember extends StatefulWidget {
  const NewMember({Key key}) : super(key: key);

  @override
  _NewMemberState createState() => _NewMemberState();
}

class _NewMemberState extends State<NewMember> {
  @override
  Widget build(BuildContext context) {
    return BaseView<MemberViewModel>(
        onModelReady: (model) {
          model.init();
          model.modalTermAndCondition(context);
        },
        statusBarTheme: Brightness.dark,
        builder: (context, model, child) {
          StepState stepIcon(int index) {
            return (model.currStep > index
                ? StepState.complete
                : model.currStep == index
                    ? StepState.editing
                    : StepState.indexed);
          }

          String nextText() {
            return (model.currStep == 6) ? "Save" : "Next";
          }

          List<Step> steps = [
            Step(
                title: Text(""),
                isActive: (model.currStep >= 0 ? true : false),
                state: stepIcon(0),
                content: Form(
                  key: model.formKey[0],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Biodata",
                        style: textLarge.merge(MyColors.ColorInputBlack),
                      ),
                      InputText(
                        bordered: true,
                        isRequered: true,
                        name: "Nama Depan",
                        controller: model.firstName,
                      ),
                      InputText(
                        bordered: true,
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
                      // InputText(
                      //   bordered: true,
                      //   isRequered: true,
                      //   textInputType: TextInputType.datetime,
                      //   placeholder: "example : dd/mm/yyyy",
                      //   name: "Tanggal Lahir",
                      //   controller: model.dateBirth,
                      // ),
                      InputDate(
                        name: "Tanggal Lahir",
                        initialDate: DateTime(1990, 01, 01),
                        minDate: DateTime(1900, 01, 01),
                        isError: !model.isTglLahir,
                        currDate: model.tglLahir,
                        onChange: model.setTglLahir,
                      ),
                      InputText(
                        bordered: true,
                        isRequered: true,
                        name: 'No KTP',
                        min: 16,
                        max: 16,
                        textInputType: TextInputType.number,
                        controller: model.noKtp,
                      ),
                      InputText(
                        bordered: true,
                        name: "NPWP",
                        max: 20,
                        min: 20,
                        customMasking: "NPWP",
                        textInputType: TextInputType.phone,
                        controller: model.npwp,
                      ),
                      InputText(
                        bordered: true,
                        name: "Nama NPWP",
                        textInputType: TextInputType.text,
                        controller: model.namaNpwp,
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
                        min: 10,
                        name: "No Handphone",
                        helperText: "example : 0895123456",
                        textInputType: TextInputType.phone,
                        controller: model.noHp,
                      ),
                    ],
                  ),
                )),
            Step(
                title: Text(""),
                isActive: (model.currStep >= 1 ? true : false),
                state: stepIcon(1),
                content: Form(
                  key: model.formKey[1],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Home Address",
                        style: textLarge.merge(MyColors.ColorInputBlack),
                      ),
                      FindDropdown<ListProvince>(
                        onFind: (String filter) {
                          return model.getProvince(filter);
                        },
                        onChanged: (ListProvince data) {
                          model.setProvince(data);
                        },
                        dropdownBuilder: (
                          BuildContext context,
                          ListProvince data,
                        ) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              width: 2,
                                              color: model.isProvince
                                                  ? Theme.of(context)
                                                      .primaryColor
                                                  : Theme.of(context)
                                                      .errorColor))),
                                  alignment: Alignment.centerLeft,
                                  child: ListTile(
                                      contentPadding: EdgeInsets.all(0),
                                      trailing:
                                          Icon(Icons.arrow_drop_down_circle),
                                      title: Text(
                                        "Provinsi",
                                        style: textSmall.merge(TextStyle(
                                            color: Theme.of(context)
                                                .primaryColor)),
                                      ),
                                      subtitle: (model.province != null)
                                          ? Text(
                                              model.province.province,
                                              style: textMedium.merge(TextStyle(
                                                  color: Colors.black)),
                                            )
                                          : Text("Pilih Provinsi"))),
                              model.isProvince
                                  ? SizedBox(
                                      height: 0,
                                    )
                                  : Text(
                                      "Provinsi is requred",
                                      style: MyColors.ColorInputError.merge(
                                          textSmall),
                                    )
                            ],
                          );
                        },
                        dropdownItemBuilder: (BuildContext context,
                            ListProvince data, bool isSel) {
                          return Container(
                            child: ListTile(
                              leading: Icon(Icons.search),
                              title: Text(data.province),
                            ),
                          );
                        },
                      ),
                      FindDropdown<ListCity>(
                        onFind: (String filter) {
                          return model.getCity(filter);
                        },
                        onChanged: (ListCity data) {
                          model.setCity(data);
                        },
                        dropdownBuilder: (
                          BuildContext context,
                          ListCity data,
                        ) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              width: 2,
                                              color: Theme.of(context)
                                                  .primaryColor))),
                                  alignment: Alignment.centerLeft,
                                  child: ListTile(
                                      contentPadding: EdgeInsets.all(0),
                                      trailing:
                                          Icon(Icons.arrow_drop_down_circle),
                                      title: Text(
                                        "Kota",
                                        style: textSmall.merge(TextStyle(
                                            color: Theme.of(context)
                                                .primaryColor)),
                                      ),
                                      subtitle: (model.city != null)
                                          ? Text(
                                              model.city.cityName,
                                              style: textMedium.merge(TextStyle(
                                                  color: Colors.black)),
                                            )
                                          : Text("Pilih Kota"))),
                              model.isCity
                                  ? SizedBox(
                                      height: 0,
                                    )
                                  : Text(
                                      "Provinsi is requred",
                                      style: MyColors.ColorInputError.merge(
                                          textSmall),
                                    )
                            ],
                          );
                        },
                        dropdownItemBuilder:
                            (BuildContext context, ListCity data, bool isSel) {
                          return Container(
                            child: ListTile(
                              leading: Icon(Icons.search),
                              title: Text(data.cityName),
                            ),
                          );
                        },
                      ),
                      FindDropdown<ListDistrict>(
                        onFind: (String filter) {
                          return model.getDistrict(filter);
                        },
                        onChanged: (ListDistrict data) {
                          model.setDistrict(data);
                        },
                        dropdownBuilder: (
                          BuildContext context,
                          ListDistrict data,
                        ) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              width: 2,
                                              color: Theme.of(context)
                                                  .primaryColor))),
                                  alignment: Alignment.centerLeft,
                                  child: ListTile(
                                      contentPadding: EdgeInsets.all(0),
                                      trailing:
                                          Icon(Icons.arrow_drop_down_circle),
                                      title: Text(
                                        "Kecamatan",
                                        style: textSmall.merge(TextStyle(
                                            color: Theme.of(context)
                                                .primaryColor)),
                                      ),
                                      subtitle: (model.district != null)
                                          ? Text(
                                              model.district.subdistrictName,
                                              style: textMedium.merge(TextStyle(
                                                  color: Colors.black)),
                                            )
                                          : Text("Pilih Kecamatan"))),
                              model.isDistrict
                                  ? SizedBox(
                                      height: 0,
                                    )
                                  : Text(
                                      "Provinsi is requred",
                                      style: MyColors.ColorInputError.merge(
                                          textSmall),
                                    )
                            ],
                          );
                        },
                        dropdownItemBuilder: (BuildContext context,
                            ListDistrict data, bool isSel) {
                          return Container(
                            child: ListTile(
                              leading: Icon(Icons.search),
                              title: Text(data.subdistrictName),
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
                    ],
                  ),
                )),
            Step(
                title: Text(""),
                isActive: (model.currStep >= 2 ? true : false),
                state: stepIcon(2),
                content: Form(
                  key: model.formKey[2],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Office Address",
                        style: textLarge.merge(MyColors.ColorInputBlack),
                      ),
                      InputText(
                        bordered: true,
                        name: "Office Address",
                        controller: model.officeAddress,
                      )
                    ],
                  ),
                )),
            Step(
                title: Text(""),
                isActive: (model.currStep >= 3 ? true : false),
                state: stepIcon(3),
                content: Form(
                  key: model.formKey[3],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Bank Account",
                        style: textLarge.merge(MyColors.ColorInputBlack),
                      ),
                      InputText(
                        bordered: true,
                        isRequered: true,
                        name: "Nama Pemilik Rekening",
                        helperText:
                            "Note : Pastikan nama pemilik rekening harus sama dengan nama KTP",
                        controller: model.nmPemilikRekening,
                      ),
                      InputText(
                        bordered: true,
                        isRequered: true,
                        min: 10,
                        max: 10,
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
                        disabled: true,
                        name: "Nama Bank",
                        controller: model.nmBank,
                      ),
                      // InputText(
                      //   bordered: true,
                      //   name: "Kode Bank",
                      //   controller: model.kdBank,
                      // ),
                    ],
                  ),
                )),
            Step(
                title: Text(""),
                isActive: (model.currStep >= 4 ? true : false),
                state: stepIcon(4),
                content: Form(
                  key: model.formKey[4],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Sponsor Information",
                        style: textLarge.merge(MyColors.ColorInputBlack),
                      ),
                      InputText(
                        bordered: true,
                        isRequered: true,
                        name: "ID Sponsor",
                        controller: model.idSponsor,
                        disabled: true,
                      ),
                      InputText(
                        bordered: true,
                        name: "Nama Sponsor",
                        controller: model.nmSponsor,
                        disabled: true,
                      ),
                      InputText(
                        bordered: true,
                        name: "Kontak Sponsor",
                        controller: model.contactSponsor,
                      ),
                      InputText(
                        bordered: true,
                        isRequered: true,
                        name: "ID Diamond Managing",
                        controller: model.idDistributorManager,
                        disabled: true,
                      ),
                      InputText(
                        bordered: true,
                        name: "Nama Diamond Managing",
                        controller: model.distributorManager,
                        disabled: true,
                      ),
                    ],
                  ),
                )),
            Step(
                title: Text(""),
                isActive: (model.currStep >= 5 ? true : false),
                state: stepIcon(5),
                content: Form(
                  key: model.formKey[5],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Upload Photo KTP",
                        style: textLarge.merge(MyColors.ColorInputBlack),
                      ),
                      Center(
                        child: InkWell(
                          onTap: () {
                            model.pictPhoto("KTP");
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
                                    "lib/_assets/images/loading.gif"),
                                image: model.busy
                                    ? AssetImage(
                                        "lib/_assets/images/loading.gif")
                                    : (model.fotoKTpFile != null)
                                        ? FileImage(model.fotoKTpFile)
                                        : AssetImage(
                                            "lib/_assets/images/ktp.png"),
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
                                    style: textLarge
                                        .merge(MyColors.ColorInputBlack),
                                  ),
                                  Center(
                                    child: InkWell(
                                      onTap: () {
                                        model.pictPhoto("NPWP");
                                      },
                                      child: Container(
                                        width: 300,
                                        height: 200,
                                        decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              new BorderRadius.circular(8.0),
                                          child: FadeInImage(
                                            fit: BoxFit.cover,
                                            placeholder: AssetImage(
                                                "lib/_assets/images/loading.gif"),
                                            image: model.busy
                                                ? AssetImage(
                                                    "lib/_assets/images/loading.gif")
                                                : (model.fotoNPWPFile != null)
                                                    ? FileImage(
                                                        model.fotoNPWPFile)
                                                    : AssetImage(
                                                        "lib/_assets/images/ktp.png"),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                    ],
                  ),
                )),
            Step(
                title: Text(""),
                isActive: (model.currStep >= 6 ? true : false),
                state: stepIcon(6),
                content: Form(
                  key: model.formKey[6],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Pilih Cara Pembayaran",
                        style: textLarge.merge(MyColors.ColorInputBlack),
                      ),
                      UIHelper.verticalSpace(20),
                      ExpansionPanelList(
                        animationDuration: Duration(milliseconds: 500),
                        expansionCallback: (int item, bool status) {
                          model.setExpanded();
                        },
                        children: [
                          ExpansionPanel(
                              isExpanded: model.isExpanded,
                              headerBuilder:
                                  (BuildContext context, bool isExpand) {
                                return Padding(
                                  padding: EdgeInsets.only(left: 8, top: 10),
                                  child: Text("Pembayaran BCA"),
                                );
                              },
                              body: BankChild(
                                  listBankChild: model.listBank.bca,
                                  onPressed: model.setPaymentMethod,
                                  selected: model.paymentMethod))
                        ],
                      ),
                      UIHelper.verticalSpace(20),
                      ExpansionPanelList(
                        animationDuration: Duration(milliseconds: 500),
                        expansionCallback: (int item, bool status) {
                          model.setExpanded();
                        },
                        children: [
                          ExpansionPanel(
                              isExpanded: model.isExpanded,
                              headerBuilder:
                                  (BuildContext context, bool isExpand) {
                                return Padding(
                                  padding: EdgeInsets.only(left: 8, top: 10),
                                  child: Text("Pembayaran Lainnya"),
                                );
                              },
                              body: BankChild(
                                  listBankChild: model.listBank.xendit,
                                  onPressed: model.setPaymentMethod,
                                  selected: model.paymentMethod))
                        ],
                      )
                    ],
                  ),
                )),
          ];

          return WillPopScope(
            onWillPop: model.goBack,
            child: Scaffold(
              appBar: AppBar(
                elevation: 0,
                title: Text(
                  "Member Registration",
                  style: textMedium,
                ),
              ),
              body: Column(
                children: <Widget>[
                  Expanded(
                    child: Stepper(
                      steps: steps,
                      type: StepperType.horizontal,
                      currentStep: model.currStep,
                      onStepContinue: model.next,
                      onStepCancel: model.back,
                      controlsBuilder: (BuildContext context,
                          {VoidCallback onStepContinue,
                          VoidCallback onStepCancel}) {
                        return Container(
                          margin: EdgeInsets.only(top: 10),
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              (model.currStep > 0)
                                  ? RaisedButton(
                                      onPressed: () {
                                        onStepCancel();
                                      },
                                      child: Text("Prev"),
                                    )
                                  : Text(""),
                              RaisedButton(
                                color: Theme.of(context).primaryColor,
                                onPressed: model.busy
                                    ? null
                                    : () {
                                        onStepContinue();
                                      },
                                child: Text(
                                  nextText(),
                                  style: MyColors.ColorInputWhite,
                                ),
                              ),
                            ],
                          ),
                        );
                      },

                      // onStepTapped: (step) => model.goToStep(step),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
