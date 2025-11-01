import 'dart:async';

import 'package:binghan_mobile/_config/locator.dart';
import 'package:binghan_mobile/_services/cart_service.dart';
import 'package:binghan_mobile/_services/member_service.dart';
import 'package:binghan_mobile/_services/navigation_service.dart';
import 'package:binghan_mobile/_services/payment_services.dart';
import 'package:binghan_mobile/models/bank.dart';
import 'package:binghan_mobile/models/invoice_callback.dart';
import 'package:binghan_mobile/models/user.dart';
import 'package:binghan_mobile/viewmodels/_basemodel.dart';
// import 'package:clipboard_manager/clipboard_manager.dart';
import 'package:flutter/material.dart';
import 'package:binghan_mobile/_constants/route_paths.dart' as routes;
import 'package:flutter/services.dart';

class CountDownViewModal extends BaseModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final PaymentService _paymentService = locator<PaymentService>();
  final CartServices _cartServices = locator<CartServices>();
  final MemberService _memberService = locator<MemberService>();

  String? get deliveryMethod => _paymentService.deliveryMethod;
  ListBankChild? get paymentMethod => _paymentService.paymentMethod;
  int? get subTotal => _cartServices.subTotal;

  ListInvoiceCallback? get listInvoiceCallback =>
      _paymentService.listInvoiceCallback;
  int? get totalOngkir => _paymentService.ongkir;
  int? get subDiscount => _cartServices.subDiscount;
  int? get handlingCost => _paymentService.handling;
  int discount = 0;

  int hour = 24;
  int minute = 0;
  Timer? timer;
  int second = 0;

  TextEditingController get kelurahan => _paymentService.kelurahan;
  TextEditingController get fullAddress => _paymentService.fullAddress;

  TextEditingController alamat = TextEditingController();

  void initCount() {
    startTimer();
  }

  int getTotal() {
    int res = (subTotal ?? 0) - discount;
    if (deliveryMethod == "Antar") res = res + (totalOngkir ?? 0);
    return res;
  }

  Future setAddress() async {
    User userData = _memberService.userData;
    alamat.text = userData.alamatRumah ?? '';
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

  void startTimer() {
    const oneSec = const Duration(seconds: 1);

    timer = Timer.periodic(oneSec, (Timer _timer) {
      if (second == 0) {
        if (hour == 0 && minute == 0) {
          timer?.cancel();
        } else {
          if (minute == 0) {
            minute = 60;
            hour--;
          } else {
            minute--;
            second = 60;
          }
        }
      } else {
        second--;
      }

      refresh();
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void goToPayment() async {
    if (deliveryMethod != null) {
      await _navigationService.navigateTo(routes.PaymentRoute);
    }
  }

  void goToPaymentDetail() async {
    await _navigationService.navigateTo(routes.PaymentDetailRoute);
  }

  Future<bool> goToRoot() async {
    int popTimes = 3;
    if (deliveryMethod != "Ambil Ditempat") popTimes = 4;
    _navigationService.goBackUntil(popTimes);
    return true;
  }
}
