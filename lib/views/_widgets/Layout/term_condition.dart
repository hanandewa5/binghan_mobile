import 'package:binghan_mobile/views/_helpers/text_helper.dart';
import 'package:binghan_mobile/views/_helpers/ui_helpers.dart';
import 'package:binghan_mobile/views/_widgets/Button/button_submit.dart';
import 'package:flutter/material.dart';

import '../Paragraft.dart';

class TermAndCondition extends StatelessWidget {
  final List<String> listTermAndCondition = [
    "Siapkan alamat email yang terdaftar di handphone pemohon.",
    "Siapkan nomor rekening BCA pemohon. Nama rekening harus sama dengan nama di KTP.",
    "Siapkan foto KTP pemohon. Pastikan hasil foto tidak buram dan wajah pemohon terlihat jelas.",
    "Siapkan foto Nomor Pokok Wajib Pajak (NPWP) jika ada.",
    "Pemohon wajib membayar biaya pendaftaran sebesar Rp 110.000,- (sudah termasuk PPN). Pemohon akan mendapatkan 1 set Business Kit.",
    "Pemohon wajib membeli minimal 1 botol Bing Han Ginseng Powder/Capsules atau Upline pemohon wajib mentransfer 1 PV untuk pemohon."
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.only(top: 20),
      child: ListView(
        children: <Widget>[
          Paragraft(
            text:
                "Sebelum mulai mengisi permohonan member baru, harap perhatikan hal-hal berikut:",
            textStyle: textMedium,
            fontSize: 16,
          ),
          UIHelper.verticalSpaceMedium(),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: listTermAndCondition.length,
            itemBuilder: (context, i) {
              return Column(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Paragraft(
                        textStyle: textThin,
                        text: "${i + 1}. ",
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.83,
                        child: Paragraft(
                          textAlign: TextAlign.justify,
                          textStyle: textThin,
                          text: listTermAndCondition[i],
                        ),
                      ),
                    ],
                  ),
                  UIHelper.verticalSpaceSmall(),
                ],
              );
            },
          ),
          UIHelper.verticalSpaceLarge(),
          ButtonSubmit(
            title: "OK",
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}
