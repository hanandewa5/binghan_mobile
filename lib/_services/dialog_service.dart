import 'dart:async';

import 'package:binghan_mobile/models/alert_request.dart';
import 'package:binghan_mobile/models/alert_response.dart';
import 'package:flutter/material.dart';

class DialogService {
  late Function(AlertRequest) _showDialogListener;
  Completer<AlertResponse>? _dialogCompleter;

  void registerDialogListener(Function(AlertRequest) showDialogListener) {
    _showDialogListener = showDialogListener;
  }

  Future<AlertResponse> showDialog(
      {required String title,
      String? descs,
      String btnTittle = 'OK',
      Icon? icon,
      String? secondBtnTittle}) {
    _dialogCompleter = Completer<AlertResponse>();
    _showDialogListener(AlertRequest(
        title: title,
        description: descs,
        buttonTitle: btnTittle,
        icon: icon,
        secondButtonTitle: secondBtnTittle));
    return _dialogCompleter!.future;
  }

  void dialogComplete(AlertResponse response) {
    _dialogCompleter?.complete(response);
    _dialogCompleter = null;
  }
}
