import 'package:binghan_mobile/viewmodels/network_viewmodel.dart';
import 'package:binghan_mobile/views/_helpers/ui_helpers.dart';
import 'package:binghan_mobile/views/_widgets/Button/button_submit.dart';
import 'package:binghan_mobile/views/_widgets/Input/input_text.dart';
import 'package:binghan_mobile/views/_widgets/Paragraft.dart';
import 'package:flutter/material.dart';
import 'package:binghan_mobile/views/base_view.dart';

class TransferPVView extends StatefulWidget {
  const TransferPVView({super.key});

  @override
  State<TransferPVView> createState() => _TransferPVViewState();
}

class _TransferPVViewState extends State<TransferPVView> {
  @override
  Widget build(BuildContext context) {
    // var _width = MediaQuery.of(context).size.width;
    // var _height = MediaQuery.of(context).size.height;
    return BaseView<NetworkViewModel>(
      onModelReady: (model) {
        model.refreshInit();
      },
      statusBarTheme: Brightness.dark,
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(
            centerTitle: true,
            title: Text("Transfer PV"),
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
                    margin: UIHelper.marginSymmetric(20, 18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Paragraft(
                          text: "Kepada : ${model.listDirect?.firstName}",
                        ),
                        Paragraft(
                          text:
                              "PV yang bisa di transfer : ${model.listDirect?.availableTransfer} PV",
                        ),
                        Form(
                          key: model.formKey,
                          child: InputText(
                            bordered: true,
                            isRequered: true,
                            name: "Jumlah PV",
                            textInputType: TextInputType.number,
                            controller: model.amount,
                          ),
                        ),
                        UIHelper.verticalSpaceMedium(),
                        SizedBox(
                          width: double.infinity,
                          child: ButtonSubmit(
                            isLoad: model.busy,
                            title: "Transfer PV",
                            onPressed: model.transferPV,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
