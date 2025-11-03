import 'dart:io';

import 'package:binghan_mobile/_config/locator.dart';
import 'package:binghan_mobile/_services/dialog_service.dart';
import 'package:binghan_mobile/_services/member_service.dart';
import 'package:binghan_mobile/_services/navigation_service.dart';
import 'package:binghan_mobile/models/city.dart';
import 'package:binghan_mobile/models/district.dart';
import 'package:binghan_mobile/models/province.dart';
import 'package:binghan_mobile/models/user.dart';
import 'package:binghan_mobile/viewmodels/_basemodel.dart';
import 'package:flutter/material.dart';
import 'package:binghan_mobile/_constants/route_paths.dart' as routes;
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

class ProfileViewModel extends BaseModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final MemberService _memberService = locator<MemberService>();
  final DialogService _dialogService = locator<DialogService>();

  GlobalKey<FormState> formBiodata = GlobalKey<FormState>();
  GlobalKey<FormState> formAlamatRumah = GlobalKey<FormState>();
  GlobalKey<FormState> formAlamatKantor = GlobalKey<FormState>();
  GlobalKey<FormState> formAkunBank = GlobalKey<FormState>();
  GlobalKey<FormState> formPassword = GlobalKey<FormState>();

  String binghanId = "";
  String name = "";
  User get userData => _memberService.userData;
  int get pointValue => _memberService.pointValue;
  int get renewalPV => _memberService.renewalPV;

  String memberClass = "";
  String memberExpiry = "";
  TextEditingController sponsorId = TextEditingController();
  TextEditingController sponsorName = TextEditingController();

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  String? gender;
  TextEditingController dateBirth = TextEditingController();
  TextEditingController noKtp = TextEditingController();
  TextEditingController npwp = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController noHp = TextEditingController();

  TextEditingController kelurahan = TextEditingController();
  TextEditingController fullAddress = TextEditingController();
  TextEditingController kdPost = TextEditingController();

  TextEditingController officeAddress = TextEditingController();

  TextEditingController nmPemilikRekening = TextEditingController();
  TextEditingController noRekening = TextEditingController();
  TextEditingController cabang = TextEditingController();
  TextEditingController nmBank = TextEditingController();
  TextEditingController kdBank = TextEditingController();

  TextEditingController oldPass = TextEditingController();
  TextEditingController newPass = TextEditingController();
  TextEditingController conNewPass = TextEditingController();

  ListProvince? province;
  ListCity? city;
  ListDistrict? district;

  bool isProvince = true;
  bool isCity = true;
  bool isDistrict = true;

  File? fotoKTpFile;
  String? fotoKTpUrl;
  File? fotoNPWPFile;
  String? fotoNPWPUrl;

  Future<void> refreshInit() async {
    await getUserData();
  }

  Future getUserData() async {
    User userDataLogin = User.fromJson(await getStorage("userData"));
    await _memberService.getUser(userDataLogin.id);
    await _memberService.getRenewalPV(userDataLogin.id);
    refresh();
  }

  Future getBiodata() async {
    firstName.text = userData.firstName ?? '';
    lastName.text = userData.lastName ?? '';
    dateBirth.text = userData.tanggalLahir ?? '';
    noKtp.text = userData.nomorKtp ?? '';
    npwp.text = userData.npwp ?? '';
    email.text = userData.email ?? '';
    noHp.text = userData.handphone ?? '';
  }

  Future getAlamatRumah() async {
    province = ListProvince.fromJson({"province": userData.propinsi});
    city = ListCity.fromJson({"city_name": userData.kota});
    district = ListDistrict.fromJson({
      "subdistrict_id": userData.kecamatanId,
      "subdistrict_name": userData.kecamatan,
    });
    kelurahan.text = userData.kelurahan ?? '';
    fullAddress.text = userData.alamatRumah ?? '';
    kdPost.text = userData.kodePos ?? '';
  }

  Future getAlamatKantor() async {
    officeAddress.text = userData.alamatKantor ?? '';
  }

  Future getAkunBank() async {
    nmPemilikRekening.text = userData.namaPemilikRekening ?? '';
    noRekening.text = userData.nomorRekening ?? '';
    cabang.text = userData.cabangBank ?? '';
    nmBank.text = userData.namaBank ?? '';
  }

  Future getDocument() async {
    email.text = userData.email ?? '';
    npwp.text = userData.npwp ?? '';
    fotoKTpUrl = userData.ktpUrl ?? '';
    fotoNPWPUrl = userData.npwpUrl ?? '';
  }

  void setProvince(ListProvince listProvince) {
    province = listProvince;
    city = null;
    district = null;
    refresh();
  }

  void setCity(ListCity listCity) {
    city = listCity;
    district = null;
    refresh();
  }

  void setDistrict(ListDistrict listDistrict) {
    district = listDistrict;
  }

  Future<List<ListProvince>> getProvince(String filter) async {
    List<ListProvince> provinces = [];
    var res = await _memberService.getProvince(filter.trim());

    if (res.data != null) {
      for (var i = 0; i < (res.data!.list?.length ?? 0); i++) {
        ListProvince suggest = res.data!.list![i];
        provinces.add(suggest);
      }
    }
    return provinces;
  }

  Future<List<ListCity>> getCity(String filter) async {
    List<ListCity> cities = [];
    var res = await _memberService.getCity(province?.provinceId, filter);
    if (res.data != null && province?.provinceId != null) {
      for (var i = 0; i < (res.data!.list?.length ?? 0); i++) {
        ListCity suggest = res.data!.list![i];
        cities.add(suggest);
      }
    }
    return cities;
  }

  Future<List<ListDistrict>> getDistrict(String filter) async {
    List<ListDistrict> district = [];
    var res = await _memberService.getDistrict(city?.cityId, filter);
    if (res.data != null && city?.cityId != null) {
      for (var i = 0; i < (res.data!.list?.length ?? 0); i++) {
        ListDistrict suggest = res.data!.list![i];
        district.add(suggest);
      }
    }
    return district;
  }

  void saveBiodata() {
    Map<String, dynamic> data = {
      "first_name": firstName.text,
      "last_name": lastName.text,
      "jenis_kelamin": gender,
      "tanggal_lahir": dateBirth.text,
      "nomor_ktp": noKtp.text,
      "npwp": npwp.text,
      "email": email.text,
      "handphone": noHp.text,
    };

    if (formBiodata.currentState!.validate()) {
      saveMember(data);
    }
  }

  Future savePassword() async {
    Map<String, dynamic> data = {
      "newPassword": newPass.text,
      "oldPassword": oldPass.text,
    };

    if (formPassword.currentState!.validate()) {
      if (newPass.text == conNewPass.text) {
        setBusy(true);
        var res = await _memberService.editPassword(userData.id, data);
        await _dialogService.showDialog(title: "Pesan !", descs: res.msg);
        setBusy(false);
        _navigationService.goBack();
      } else {
        _dialogService.showDialog(
          title: "Pesan !",
          descs: "Password tidak match",
        );
      }
      // saveMember(data);
    }
  }

  void saveAlamatRumah() {
    String homeAdress() {
      return "${province?.province}, ${city?.cityName}, ${district?.subdistrictName}, ${kelurahan.text}, ${fullAddress.text}";
    }

    bool isValid = false;

    if (province == null) {
      isProvince = false;
      isValid = false;
    } else {
      isProvince = true;
      isValid = true;
    }

    if (city == null) {
      isCity = false;
      isValid = false;
    } else {
      isCity = true;
      isValid = true;
    }

    if (district == null) {
      isDistrict = false;
      isValid = false;
    } else {
      isDistrict = true;
      isValid = true;
    }
    refresh();

    if (formAlamatRumah.currentState!.validate() && isValid) {
      Map<String, dynamic> data = {
        "propinsi": province?.province,
        "kota": city?.cityName,
        "kecamatan": district?.subdistrictName,
        "kecamatan_id": district?.subdistrictId,
        "kelurahan": kelurahan.text,
        "alamat_rumah": homeAdress(),
        "kode_pos": kdPost.text,
      };
      saveMember(data);
    }
  }

  void saveAlamatKantor() {
    Map<String, dynamic> data = {"alamat_kantor": officeAddress.text};

    if (formAlamatKantor.currentState!.validate()) {
      saveMember(data);
    }
  }

  void saveAkunBank() {
    Map<String, dynamic> data = {
      "nama_pemilik_rekening": nmPemilikRekening.text,
      "nomor_rekening": noRekening.text,
      "cabang_bank": cabang.text,
      "nama_bank": nmBank.text,
    };

    if (formAkunBank.currentState!.validate()) {
      saveMember(data);
    }
  }

  Future saveDocument() async {
    setBusy(true);
    Map<String, dynamic> data = {
      "file": fotoKTpFile,
      "jenis_file": "KTP",
      "nama_file": "${email.text}-KTP",
    };
    var res = await _memberService.uploadImage(data);
    if (res.data != null) {
      if (res.code == 200) {
        fotoKTpUrl = res.data["url"];
        if (fotoNPWPFile != null) {
          Map<String, dynamic> data = {
            "file": fotoNPWPFile,
            "jenis_file": "NPWP",
            "nama_file": "${email.text}-NPWP",
          };
          var res = await _memberService.uploadImage(data);
          if (res.data != null) {
            if (res.code == 200) {
              fotoNPWPUrl = res.data["url"];
              Map<String, dynamic> formData = {
                "ktp_url": fotoKTpUrl,
                "npwp_url": fotoNPWPUrl,
              };
              saveMember(formData);
            } else {
              await _dialogService.showDialog(title: "Error", descs: res.msg);
            }
          } else {
            await _dialogService.showDialog(
              title: "Error",
              descs: "Terjadi kesalaha, harap coba lagi",
            );
          }
        } else {
          Map<String, dynamic> formData = {"ktp_url": fotoKTpUrl};
          saveMember(formData);
        }
      } else {
        await _dialogService.showDialog(title: "Error", descs: res.msg);
      }
    } else {
      await _dialogService.showDialog(
        title: "Error",
        descs: "Terjadi kesalaha, harap coba lagi",
      );
    }
    setBusy(false);
  }

  Future saveMember(Map<String, dynamic> data) async {
    User userData = _memberService.userData;
    var res = await _memberService.editMember(userData.id, data);
    var titleMsg = "Error !";
    if (res.code == 200) {
      titleMsg = "Success";
    }
    await _dialogService.showDialog(title: titleMsg, descs: res.msg);
    if (res.code == 200) {
      var res = await _memberService.getUser(userData.id);
      if (res.code == 200) {
        refresh();
      }
      _navigationService.goBack();
    }
  }

  Future logout() async {
    var res = await _dialogService.showDialog(
      title: "Logout",
      descs: "Are you sure ?",
      secondBtnTittle: "Cancel",
    );
    setBusy(true);

    if (res.confirmed) {
      User userData = _memberService.userData;
      Map<String, dynamic> data = {"firebase_token": "null"};
      var res = await _memberService.editMember(userData.id, data);

      if (res.code != 200) {
        await _dialogService.showDialog(title: "Alert ", descs: "Gagal Logout");
      } else {
        await setStorage("isLogin", false);
        await Future.delayed(Duration(seconds: 1));
        _navigationService.reset(routes.LoginRoute);
      }
    }
    setBusy(false);
  }

  void goToEditProfileList() {
    _navigationService.navigateTo(routes.EditProfileListRoute);
  }

  Future pictPhoto() async {
    User userData = _memberService.userData;
    var resDialog = await _dialogService.showDialog(
      title: "Pilih source foto",
      btnTittle: "Camera",
      secondBtnTittle: "Gallery",
    );
    ImageSource? source;
    if (resDialog.secondConfirmed) {
      source = ImageSource.gallery;
    } else if (resDialog.confirmed) {
      source = ImageSource.camera;
    }

    if (source != null) {
      var image = await ImagePicker().pickImage(
        source: source,
        maxWidth: 300,
        maxHeight: 300,
      );
      setBusy(true);
      Map<String, dynamic> data = {
        "file": image,
        "jenis_file": "Profile",
        "nama_file":
            "${userData.email}-Profile-${DateTime.now().millisecondsSinceEpoch}",
      };

      var res = await _memberService.uploadImage(data);
      setBusy(false);
      if (res.data != null) {
        if (res.code == 200) {
          Map<String, dynamic> dataSave = {"photo_url": res.data["url"]};
          saveMember(dataSave);
          refresh();
        } else {
          await _dialogService.showDialog(title: "Error", descs: res.msg);
        }
      } else {
        await _dialogService.showDialog(
          title: "Error",
          descs: "Terjadi kesalahan, harap coba lagi",
        );
      }
    }
  }

  Future pictPhotoDoc(String jenisFile) async {
    var resDialog = await _dialogService.showDialog(
      title: "Pilih source foto",
      btnTittle: "Camera",
      secondBtnTittle: "Gallery",
    );
    var source;
    if (resDialog.secondConfirmed) {
      source = ImageSource.gallery;
    } else if (resDialog.confirmed) {
      source = ImageSource.camera;
    }

    if (source != null) {
      var image = await ImagePicker().pickImage(source: source);
      if (image != null) {
        final croppedFile = await ImageCropper().cropImage(
          compressQuality: 50,
          sourcePath: image.path,
          aspectRatio: jenisFile == "KTP"
              ? CropAspectRatio(ratioX: 323, ratioY: 204)
              : CropAspectRatio(ratioX: 500, ratioY: 364),
        );
        if (croppedFile != null) {
          setBusy(true);
          if (jenisFile == "KTP") {
            fotoKTpFile = File(croppedFile.path);
          } else {
            fotoNPWPFile = File(croppedFile.path);
          }
          setBusy(false);
        }
        refresh();
      }
    }
  }

  void setJenisKelamin(String? value) {
    gender = value;
    refresh();
  }

  void goToEditProfile(String route) {
    if (route == "logout") {
      logout();
    } else {
      _navigationService.navigateTo(route);
    }
  }
}
