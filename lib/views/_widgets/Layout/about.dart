import 'package:binghan_mobile/viewmodels/auth_viewmodel.dart';
import 'package:binghan_mobile/views/_helpers/text_helper.dart';
import 'package:binghan_mobile/views/_helpers/ui_helpers.dart';
import 'package:binghan_mobile/views/_widgets/Layout/carouselAbout.dart';
import 'package:binghan_mobile/views/_widgets/Paragraft.dart';
import 'package:flutter/material.dart';
import '../../base_view.dart';

class AboutCarousel extends StatefulWidget {
  @override
  _AboutCarouselState createState() => _AboutCarouselState();
}

class _AboutCarouselState extends State<AboutCarousel> {
  @override
  Widget build(BuildContext context) {
    return BaseView<AuthViewModel>(
      statusBarTheme: Brightness.dark,
      builder: (context, model, child) {
        List<Map<String, dynamic>> carouselList = [
          {
            "imgUrl": "lib/_assets/images/pic2.jpg",
            "title": "BING HAN Ginseng",
            "descs":
                "BING HAN Ginseng menggunakan bahan Panax Ginseng dari pegunungan Chang Bai yang telah berumur 6 tahun keatas, berwarna putih bersih. Diproses khusus dengan sistem nano teknologi modern yang menggunakan suhu rendah 28oC, melewati 14 proses dan kemudian diekstrak 4 kali untuk diambil sari patinya, dalam 20 menit dapat diserap dalam tubuh.",
            "descriptions": [
              {
                "style": textThin,
                "text":
                    "BING HAN Ginseng menggunakan bahan Panax Ginseng dari pegunungan Chang Bai yang telah berumur 6 tahun keatas, berwarna putih bersih. Diproses khusus dengan sistem nano teknologi modern yang menggunakan suhu rendah 28oC, melewati 14 proses dan kemudian diekstrak 4 kali untuk diambil sari patinya, dalam 20 menit dapat diserap dalam tubuh.",
              },
              {
                "style": textThin,
                "text": "",
              },
              {
                "style": textThin,
                "text":
                    "Proses ini adalah merupakan paten satu-satunya di seluruh dunia dan hanya dimiliki oleh Prof. Dr. Li He Shun saja.",
              },
              {
                "style": textThin,
                "text": "",
              },
              {
                "style": textThin,
                "text":
                    "Melalui tahap proses pengeringan dengan suhu rendah 28oC tersebut, maka kandungan alamiah ginseng, vitamin dan mineralnya yang lebih dari 160 jenis tersebut masih tetap tidak berubah.",
              },
              {
                "style": textThin,
                "text": "",
              },
              {
                "style": textThin,
                "text":
                    "Berbeda dengan pengolahan ginseng yang umumnya menggunakan suhu 128oC, dimasak dan direbus 6 kali dengan membuang akar dan kulit luarnya sehingga banyak vitamin dan mineral yang terbuang. Cara ini merubah sifat alami ginseng tersebut. Sifat ginseng itu akan berubah sangat tonik dan panas, yang menyebabkan tidak cocok dikonsumsi oleh semua orang.",
              },
              {
                "style": textThin,
                "text": "",
              },
              {
                "style": textThin,
                "text":
                    "Dengan mempertahankan sifat alaminya tersebut, maka BING HAN Ginseng Powder aman untuk dikonsumsi oleh semua orang",
              },
              {
                "style": textThin,
                "text": "",
              },
              {
                "style": textThin,
                "text": "BING HAN Ginseng Powder mempunyai DWI FUNGSI :"
              },
              {
                "style": textThin,
                "text": "-	Menambah (darah + O2), Membuang (racun + lemak)"
              },
              {"style": textThin, "text": "-	Menghangatkan, Mendinginkan"},
              {
                "style": textThin,
                "text": "Perbandingan Ginseng Tradisional dan BING HAN Ginseng"
              },
              {
                "style": textThin,
                "text": "",
              },
              {"style": textThin, "text": "Ginseng Tradisional"},
              {"style": textThin, "text": "•	Usia 1-6 tahun"},
              {
                "style": textThin,
                "text": "•	Kulit dikupas,  rambut & akar ginseng dibuang"
              },
              {"style": textThin, "text": "•	Di-oven hingga 128°C"},
              {
                "style": textThin,
                "text":
                    "•	Bergizi dan bersifat sangat panas, tidak cocok untuk kondisi tubuh kebanyakan orang"
              },
              {"style": textThin, "text": "BING HAN Ginseng"},
              {
                "style": textThin,
                "text":
                    "•	Memakai seluruh bagian tubuh ginseng berumur diatas 6 tahun"
              },
              {
                "style": textThin,
                "text":
                    "•	Menggunakan teknologi biokimia, diproses dengan suhu rendah 28°C, dikonsentrat 4 kali"
              },
              {
                "style": textThin,
                "text":
                    "•	Mempertahankan unsur alami dari Ginseng, tidak bersifat panas"
              },
              {"style": textThin, "text": "•	Cocok untuk segala kondisi tubuh"}
            ]
          },
          {
            "imgUrl": "lib/_assets/images/pic1.jpg",
            "title": "The Millennium Essence – Bing Han Ginseng",
            "descs":
                "BING HAN Ginseng menggunakan bahan Panax Ginseng dari pegunungan Chang Bai yang telah berumur 6 tahun keatas, berwarna putih bersih. Diproses khusus dengan sistem nano teknologi modern yang menggunakan suhu rendah 28oC, melewati 14 proses dan kemudian diekstrak 4 kali untuk diambil sari patinya, dalam 20 menit dapat diserap dalam tubuh.",
            "descriptions": [
              {
                "style": textThin,
                "text":
                    "Memegang filosofi ‘Menghargai kehidupan untuk menciptakan kesehatan dan masyarakat yang harmonis”, Grup Internasional Bing Han telah terlibat di dalam bisnis ginseng sejak tahun 1991. Mulai dari proses penanaman, produksi, pembuatan sampai ke penjualan, kami telah memasarkan produk kami lebih dari 10 negara di dunia. Dengan dedikasi yang cukup besar, Bing Han selalu bekerja keras untuk tujuan utama yakni memperbaiki kualitas produk.",
              },
              {
                "style": textThin,
                "text": "",
              },
              {
                "style": textThin,
                "text":
                    "Menjaga standar GMP dan ISO, Bing Han menjalankan kontrol kualitas secara serius dan aktif dalam kegiatan inovasi, penelitian, dan pengembangan. Produk kami telah mendapatkan banyak sertifikasi baik di dalam ataupun di luar negeri, termasuk ijin pangan sehat Taiwan, pangan sehat impor di China, sertifikat DNA makanan yang dikeluarkan oleh Menteri Kesehatan, Tenaga Kerja, dan Kesejahteraan di Jepang, sertifikat STC (Pusat Standar dan Test) Hongkong, dan sertifikat halal Islam, yang memperlihatkan pencapaian besar kami.",
              },
              {
                "style": textThin,
                "text": "",
              },
              {
                "style": textThin,
                "text":
                    "Bing Han memiliki komitmen pada penelitian dan pengembangan bioteknologi “hijau” dalam pandangan bahaya dari pupuk kimia yang ada pada lahan pertanian, ekologi dan kesehatan manusia. Sebagai hasilnya, Bing Han telah mendapatkan sertifikat organik USDA dan EU untuk bahan ginseng mentah pada tahun 2013 dan sertifikat organik Taiwan, USDA dan EU untuk produk ginseng pada April dan Mei 2014.",
              },
              {
                "style": textThin,
                "text": "",
              },
              {
                "style": textThin,
                "text":
                    "Pada saat yang sama, Bing Han mendapatkan sertifikat ISO 22000 dan HACCP untuk memperkuat standar manajemen keamanan pangan dan menyediakan konsumen dengan kepercayaan dan jaminan yang lebih baik. Bing Han akan melanjutkan untuk berfokus pada perbaikan kualitas produknya, menciptakan tanggung jawab untuk melindungi Bumi dan mengurangi kekhawatiran konsumen.",
              }
            ]
          },
        ];

        return Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: <Widget>[
              carouselImage(carouselList, MediaQuery.of(context)),
            ],
          ),
        );
      },
    );
  }

  Widget carouselImage(List carouselList, MediaQueryData mediaQuery) {
    List<T> map<T>(List list, Function handler) {
      List<T> result = [];
      for (var i = 0; i < list.length; i++) {
        result.add(handler(i, list[i]));
      }

      return result;
    }

    final List child = map<Widget>(
      carouselList,
      (index, var i) {
        return SingleChildScrollView(
          child: Container(
            margin: UIHelper.marginSymmetric(80, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Image.asset(carouselList[index]["imgUrl"]),
                ),
                Text(
                  carouselList[index]["title"],
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                // Container(
                //   child: Image.asset("name"),
                // ),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: carouselList[index]["descriptions"].length,
                  itemBuilder: (context, i) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Paragraft(
                          textStyle: carouselList[index]["descriptions"][i]
                              ["style"],
                          text: carouselList[index]["descriptions"][i]["text"],
                          color: Colors.black54,
                        ),
                      ],
                    );
                  },
                )
              ],
            ),
          ),
        );
      },
    ).toList();
    return CarouselAbout(
      items: child,
    );
  }
}

class IconText extends StatelessWidget {
  const IconText({
    this.iconData,
    this.text,
    this.onPress,
    Key key,
  }) : super(key: key);

  final String iconData;
  final String text;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image(
              width: 35,
              height: 35,
              color: Colors.black,
              image: AssetImage(iconData),
            ),
            Text(
              text,
              style: TextStyle(fontSize: 12),
            )
          ],
        ),
      ),
    );
  }
}
