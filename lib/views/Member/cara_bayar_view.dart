import 'package:binghan_mobile/viewmodels/member_viewmodel.dart';
import 'package:binghan_mobile/views/_helpers/indo_locale.dart';
import 'package:binghan_mobile/views/_helpers/text_helper.dart';
import 'package:binghan_mobile/views/_helpers/ui_helpers.dart';
import 'package:binghan_mobile/views/_widgets/Paragraft.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../base_view.dart';

class CaraBayarMemberView extends StatefulWidget {
  const CaraBayarMemberView({super.key});

  @override
  State<CaraBayarMemberView> createState() => _CaraBayarMemberViewState();
}

class _CaraBayarMemberViewState extends State<CaraBayarMemberView> {
  @override
  Widget build(BuildContext context) {
    Color _bgColor = Theme.of(context).scaffoldBackgroundColor;
    return BaseView<MemberViewModel>(
      onModelReady: (model) {
        model.startTimer();
      },
      statusBarTheme: Brightness.dark,
      builder: (context, model, child) {
        return WillPopScope(
          onWillPop: model.goToRoot,
          child: Scaffold(
            backgroundColor: _bgColor,
            appBar: AppBar(
              elevation: 0,
              centerTitle: true,
              title: Text("Cara Pembayaran", style: textMedium),
            ),
            body: model.invoiceUrl?.method == "BCA"
                ? CartList(model: model)
                : WebViewWidget(
                    controller: WebViewController()
                      ..setJavaScriptMode(JavaScriptMode.unrestricted)
                      ..loadRequest(
                        Uri.parse(model.invoiceUrl?.urlInvoice ?? ''),
                      ),
                  ),
          ),
        );
      },
    );
  }
}

class CartList extends StatelessWidget {
  final MemberViewModel model;

  const CartList({required this.model, super.key});

  @override
  Widget build(BuildContext context) {
    // bool isExpanded = false;

    Color colorAccent = Theme.of(context).colorScheme.secondary;
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: UIHelper.marginSymmetric(10, 0),
            padding: UIHelper.marginSymmetric(20, 10),
            decoration: BoxDecoration(
              color: Colors.black12,
              border: Border.all(width: 1, color: colorAccent),
            ),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      "SEGERA LAKUKAN PEMBAYARAN DALAM WAKTU",
                      textAlign: TextAlign.center,
                    ),
                    UIHelper.verticalSpaceSmall(),
                    Text(
                      "${model.hour} Jam : ${model.minute} Menit : ${model.second} Detik",
                    ),
                    UIHelper.verticalSpaceSmall(),
                    Text(
                      "Sebelum hari ${formatDate(DateTime.now().add(Duration(days: 1)), [DD, ', ', dd, ' ', MM, ' ', yyyy, ', ', HH, ':', mm], locale: IndoLocale())} WIB",
                      style: textThin,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              UIHelper.verticalSpaceMedium(),
              Text("Transfer ke nomor Virtual Account :"),
              UIHelper.verticalSpaceSmall(),
              Row(
                children: <Widget>[
                  Image(
                    width: 90,
                    height: 70,
                    fit: BoxFit.cover,
                    image: NetworkImage(model.paymentMethod?.logoUrl ?? ''),
                  ),
                  UIHelper.horizontalSpaceMedium(),
                  Paragraft(
                    text: "${model.invoiceUrl?.urlInvoice}",
                    fontSize: 18,
                  ),
                ],
              ),
              UIHelper.verticalSpaceMedium(),
              InkWell(
                onTap: () {
                  return model.clickToCopy(
                    context,
                    "${model.invoiceUrl?.urlInvoice}",
                  );
                },
                child: Paragraft(
                  text: "Salin no rek",
                  textStyle: textThin.merge(
                    TextStyle(decoration: TextDecoration.underline),
                  ),
                ),
              ),
              UIHelper.verticalSpaceMedium(),
              Divider(height: 1, color: Colors.black),
              UIHelper.verticalSpaceMedium(),
              Paragraft(
                text: "Jumlah yang harus dibayar:",
                color: Colors.black87,
              ),
              UIHelper.verticalSpaceMedium(),
              Paragraft(
                text: formatIDR(model.invoiceUrl?.total ?? 0),
                color: colorAccent,
              ),
              UIHelper.verticalSpaceMedium(),
              InkWell(
                onTap: () {
                  model.clickToCopy(
                    context,
                    model.invoiceUrl?.total?.toString() ?? '',
                  );
                },
                child: Paragraft(
                  text: "Salin jumlah",
                  textStyle: textThin.merge(
                    TextStyle(decoration: TextDecoration.underline),
                  ),
                ),
              ),
              UIHelper.verticalSpaceMedium(),
            ],
          ),
          // InkWell(
          //   onTap: () {
          //     return model.goToPaymentDetail();
          //   },
          //   child: Paragraft(
          //     text: "Lihat Detail Pembayaran",
          //   ),
          // )
        ],
      ),
    );
  }

  Widget rowDetail({
    String? first,
    String? second,
    Color secondColor = Colors.black,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(first ?? ''),
        Text(
          second ?? '',
          style: textThin.merge(TextStyle(color: secondColor)),
        ),
      ],
    );
  }
}
