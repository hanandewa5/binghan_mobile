import 'dart:async';
import 'dart:io';

import 'package:binghan_mobile/_config/locator.dart';
import 'package:binghan_mobile/_services/dialog_service.dart';
import 'package:binghan_mobile/_services/member_service.dart';
import 'package:binghan_mobile/_services/navigation_service.dart';
import 'package:binghan_mobile/_services/payment_services.dart';
import 'package:binghan_mobile/models/bank.dart';
import 'package:binghan_mobile/models/city.dart';
import 'package:binghan_mobile/models/district.dart';
import 'package:binghan_mobile/models/invoice_callback.dart';
import 'package:binghan_mobile/models/province.dart';
import 'package:binghan_mobile/models/user.dart';
import 'package:binghan_mobile/viewmodels/_basemodel.dart';
import 'package:binghan_mobile/views/_widgets/Layout/term_condition.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:binghan_mobile/_constants/route_paths.dart' as routes;
import 'package:image_cropper/image_cropper.dart';

class MemberViewModel extends BaseModel {
  final MemberService _memberService = locator<MemberService>();
  final PaymentService _paymentService = locator<PaymentService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();

  int currStep = 0;
  bool complete = false;
  File? fotoKTpFile;
  String? fotoKTpUrl;
  int? sponId;
  int? dmId;
  DateTime? tglLahir;

  File? fotoNPWPFile;
  String? fotoNPWPUrl;

  ListProvince? province;
  ListCity? city;
  ListDistrict? district;

  ListBank listBank = ListBank.fromJson({
    "BCA": [],
    "Manual": [],
    "Xendit": [],
  });
  ListBankChild? get paymentMethod => _memberService.paymentMethod;
  ListInvoiceCallback? get invoiceUrl => _memberService.invoiceUrl;

  bool isProvince = true;
  bool isCity = true;
  bool isDistrict = true;
  bool isTglLahir = true;
  bool isExpanded = false;
  int hour = 24;
  int minute = 0;
  Timer? timer;
  int second = 0;

  List<GlobalKey<FormState>> formKey = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
  ];

  // ? Text Input Controller
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  String? gender;
  TextEditingController dateBirth = TextEditingController();
  TextEditingController noKtp = TextEditingController();
  TextEditingController npwp = TextEditingController();
  TextEditingController namaNpwp = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController noHp = TextEditingController();

  TextEditingController kelurahan = TextEditingController();
  TextEditingController fullAddress = TextEditingController();
  TextEditingController kdPost = TextEditingController();

  TextEditingController officeAddress = TextEditingController();

  TextEditingController nmPemilikRekening = TextEditingController();
  TextEditingController noRekening = TextEditingController();
  TextEditingController cabang = TextEditingController();
  TextEditingController nmBank = TextEditingController(text: "BCA");
  TextEditingController kdBank = TextEditingController();

  TextEditingController idSponsor = TextEditingController();
  TextEditingController nmSponsor = TextEditingController();
  TextEditingController contactSponsor = TextEditingController();
  TextEditingController idDistributorManager = TextEditingController();
  TextEditingController distributorManager = TextEditingController();

  // ? Dropdown Controller
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

  void setTglLahir(DateTime date) {
    tglLahir = DateTime(date.year, date.month, date.day);
    refresh();
  }

  void init() {
    setidSponsor();
    getBank();
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);

    timer = Timer.periodic(oneSec, (Timer _timer) {
      if (second == 0) {
        if (hour == 0 && minute == 0) {
          timer?.cancel();
        } else {
          if (minute == 0) {
            minute = 59;
            hour--;
          } else {
            minute--;
            second = 59;
          }
        }
      } else {
        second--;
      }

      refresh();
    });
  }

  void clickToCopy(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    final snackBar = SnackBar(
      content: Text('Copied to Clipboard'),
      action: SnackBarAction(label: 'OK', onPressed: () {}),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    Clipboard.setData(ClipboardData(text: text));
    // ClipboardManager.copyToClipBoard(text).then((result) {
    //   final snackBar = SnackBar(
    //     content: Text('Copied to Clipboard'),
    //     action: SnackBarAction(
    //       label: 'OK',
    //       onPressed: () {},
    //     ),
    //   );
    //   Scaffold.of(context).showSnackBar(snackBar);
    // });
  }

  void modalTermAndCondition(BuildContext context) {
    Future.delayed(Duration(seconds: 1), () {
      showModalBottomSheet(
        context: context,
        isDismissible: true,
        isScrollControlled: true,
        builder: (BuildContext bc) {
          return TermAndCondition();
        },
      );
    });
  }

  Future setidSponsor() async {
    User userData = _memberService.userData;
    idSponsor.text = userData.binghanId ?? '';
    nmSponsor.value = TextEditingValue(
      text: "${userData.firstName} ${userData.lastName}",
    );
    contactSponsor.value = TextEditingValue(
      text: userData.handphone.toString(),
    );
    distributorManager.text = userData.distributorManager ?? '';
    idDistributorManager.text = userData.distributorManagerId ?? '';
    dmId = userData.dmId;
    sponId = userData.id;
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
    var res = await _memberService.getCity(province?.provinceId ?? 0, filter);
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
    var res = await _memberService.getDistrict(city?.cityId ?? 0, filter);
    if (res.data != null && city?.cityId != null) {
      for (var i = 0; i < (res.data!.list?.length ?? 0); i++) {
        ListDistrict suggest = res.data!.list![i];
        district.add(suggest);
      }
    }
    return district;
  }

  Future getBank() async {
    var res = await _paymentService.getBank();
    if (res.code == 200 && res.data != null) {
      listBank = res.data!.list!;
    }
  }

  Future saveMember() async {
    try {
      Map<String, dynamic> data = {
        "alamat_kantor": officeAddress.text,
        "alamat_rumah": homeAdress(),
        "approved_by": null,
        "cabang_bank": cabang.text,
        "dm_id": dmId,
        "distributor_manager": distributorManager.text,
        "distributor_manager_id": idDistributorManager.text,
        "email": email.text,
        "first_name": firstName.text,
        "last_name": lastName.text,
        "handphone": noHp.text,
        "sponsor_id": sponId,
        "jenis_kelamin": gender,
        "kecamatan_id": district?.subdistrictId,
        "kecamatan": district?.subdistrictName,
        "kelurahan": kelurahan.text,
        "kode_pos": kdPost.text,
        "kota": city?.cityName,
        "ktp_url": "$fotoKTpUrl",
        "npwp_url": "$fotoNPWPUrl",
        "nama_bank": nmBank.text,
        "payment_method_id": paymentMethod?.id,
        "nama_pemilik_rekening": nmPemilikRekening.text,
        "nama_sponsor": nmSponsor.text,
        "nomor_ktp": noKtp.text,
        "nomor_rekening": noRekening.text,
        "npwp": npwp.text,
        "namanpwp": namaNpwp.text,
        "propinsi": province?.province,
        "tanggal_lahir": formatDate(tglLahir!, [dd, "/", mm, "/", yyyy]),
        "telepon_sponsor": contactSponsor.text,
      };
      var resDialog = await _dialogService.showDialog(
        title: "Perhatian",
        descs: "Harap pastikan data yang akan anda simpan sudah benar",
      );
      if (resDialog.confirmed) {
        var res = await _memberService.saveMember(data);
        var titleMsg = "Error !";
        if (res.code == 200) {
          titleMsg = "Success";
        }
        await _dialogService.showDialog(title: titleMsg, descs: res.msg);
        if (res.code == 200) {
          _navigationService.navigateTo(routes.CaraBayarMemberRoute);
        }
      }
    } catch (e) {
      await _dialogService.showDialog(
        title: "Terjadi Kesalahan!",
        descs: e.toString(),
      );
    }
  }

  Future editMember(String token) async {
    User userData = _memberService.userData;

    Map<String, dynamic> data = {"firebase_token": token};
    var res = await _memberService.editMember(userData.id ?? 0, data);

    if (res.code != 200) {
      await _dialogService.showDialog(
        title: "Alert ",
        descs: "Token gagal update",
      );
    }
  }

  String homeAdress() {
    return "${province?.province}, ${city?.cityName}, ${district?.subdistrictName}, ${kelurahan.text}, ${fullAddress.text}";
  }

  Future pictPhoto(String jenisFile) async {
    var resDialog = await _dialogService.showDialog(
      title: "Pilih source foto",
      btnTittle: "Camera",
      secondBtnTittle: "Gallery",
    );
    var source = ImageSource.camera;
    if (resDialog.secondConfirmed) {
      source = ImageSource.gallery;
    }

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
        Map<String, dynamic> data = {
          "file": croppedFile,
          "jenis_file": jenisFile,
          "nama_file": "${email.text}-$jenisFile",
        };
        var res = await _memberService.uploadImage(data);
        setBusy(false);
        if (res.data != null) {
          if (res.code == 200) {
            if (jenisFile == "KTP") {
              fotoKTpUrl = res.data["url"];
              fotoKTpFile = File(croppedFile.path);
            } else {
              fotoNPWPUrl = res.data["url"];
              fotoNPWPFile = File(croppedFile.path);
            }
            refresh();
          } else {
            await _dialogService.showDialog(title: "Error", descs: res.msg);
          }
        } else {
          await _dialogService.showDialog(
            title: "Error",
            descs: "Terjadi kesalaha, harap coba lagi",
          );
        }
      }
      refresh();
    }
  }

  void setJenisKelamin(String value) {
    gender = value;
    refresh();
  }

  void setExpanded() {
    isExpanded = !isExpanded;
    refresh();
  }

  void setPaymentMethod(ListBankChild bank) {
    _memberService.setPaymentMethod(bank);
    refresh();
  }

  next() {
    bool isValid = true;
    bool isFoto = true;
    bool isFotoNpwp = true;

    if (currStep == 1) {
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
    } else if (currStep == 0) {
      if (tglLahir == null) {
        isTglLahir = false;
        isValid = false;
      } else {
        isTglLahir = true;
        isValid = true;
      }
    } else {
      isValid = true;
    }

    if (currStep == 5) {
      if (fotoKTpUrl == null) {
        isFoto = false;
      } else {
        isFoto = true;
      }

      if (npwp.text != "") {
        if (fotoNPWPUrl == null || fotoNPWPUrl == "") {
          isFotoNpwp = false;
        } else {
          isFotoNpwp = true;
        }
      }
    }

    if (currStep == 6) {
      if (paymentMethod == null) {
        isValid = false;
      }
    }

    if (formKey[currStep].currentState!.validate() &&
        isValid &&
        isFoto &&
        isFotoNpwp) {
      currStep + 1 != 7 ? goToStep(currStep + 1) : completing();
    }
    refresh();
  }

  back() {
    if (currStep > 0) {
      goToStep(currStep - 1);
    }
  }

  goToStep(int step) {
    currStep = step;
    refresh();
  }

  completing() {
    complete = true;
    refresh();
    saveMember();
  }

  Future<bool> goBack() async {
    var resDialog = await _dialogService.showDialog(
      title: "Apakah anda ingin kembali ?",
      descs: "Jika iya maka data yang telah anda isi akan ke reset",
    );
    return resDialog.confirmed;
  }

  Future<bool> goToRoot() async {
    _navigationService.goBackUntil(1);
    return true;
  }
}
