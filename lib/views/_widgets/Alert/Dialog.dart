import 'package:binghan_mobile/models/alert_request.dart';
import 'package:binghan_mobile/models/alert_response.dart';
import 'package:binghan_mobile/views/_helpers/color_helper.dart';
import 'package:binghan_mobile/views/_helpers/text_helper.dart';
import 'package:binghan_mobile/views/_widgets/Paragraft.dart';
import 'package:flutter/material.dart';
import 'package:binghan_mobile/_config/locator.dart';
import 'package:binghan_mobile/_services/dialog_service.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class DialogManager extends StatefulWidget {
  final Widget child;
  const DialogManager({super.key, required this.child});

  @override
  State<DialogManager> createState() => _DialogManagerState();
}

class _DialogManagerState extends State<DialogManager> {
  final DialogService _dialogService = locator<DialogService>();

  @override
  void initState() {
    super.initState();
    _dialogService.registerDialogListener(_showDialog);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  void _showDialog(AlertRequest request) {
    List<DialogButton> listButton = [];

    if (request.secondButtonTitle != null) {
      listButton.add(
        DialogButton(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[Text(request.secondButtonTitle ?? '')],
          ),
          onPressed: () {
            _dialogService.dialogComplete(
              AlertResponse(confirmed: false, secondConfirmed: true),
            );
            Navigator.of(context).pop();
          },
        ),
      );
    }

    listButton.add(
      DialogButton(
        color: MyColors.ColorPrimary,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Paragraft(text: request.buttonTitle, color: Colors.white),
          ],
        ),
        onPressed: () {
          _dialogService.dialogComplete(
            AlertResponse(confirmed: true, secondConfirmed: false),
          );
          Navigator.of(context).pop();
        },
      ),
    );

    Alert(
      context: context,
      title: request.title,
      desc: request.description,
      style: AlertStyle(descStyle: textThinBold.merge(TextStyle(fontSize: 16))),
      buttons: listButton,
    ).show();
  }
}
