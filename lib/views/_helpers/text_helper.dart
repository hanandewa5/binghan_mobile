import 'package:flutter/material.dart';

const headerStyle = TextStyle(
  fontSize: 25,
  color: Colors.white,
  fontWeight: FontWeight.w900,
  fontFamily: "Poppins-Bold",
);
const headerStyleBlack = TextStyle(
  fontSize: 25,
  fontWeight: FontWeight.w900,
  fontFamily: "Poppins-Bold",
);
const subHeaderStyle = TextStyle(
  fontSize: 16.0,
  fontWeight: FontWeight.w500,
  fontFamily: "Poppins-Bold",
);
const btnTextBlack = TextStyle(
  fontSize: 12.0,
  fontWeight: FontWeight.w500,
  fontFamily: "Poppins-Bold",
);
const btnTextWhite = TextStyle(
  color: Colors.white,
  fontSize: 15.0,
  fontWeight: FontWeight.w500,
  fontFamily: "Poppins-Bold",
);
const textSmall = TextStyle(
  fontSize: 12.0,
  fontWeight: FontWeight.w500,
  fontFamily: "Poppins-Bold",
);
const textSmallWhite = TextStyle(
  color: Colors.white,
  fontSize: 12.0,
  fontWeight: FontWeight.w500,
  fontFamily: "Poppins-Bold",
);
const textMediumSmall = TextStyle(
  fontSize: 14.0,
  fontWeight: FontWeight.w500,
  fontFamily: "Poppins-Bold",
);
const textMedium = TextStyle(
  fontSize: 16.0,
  fontWeight: FontWeight.w500,
  fontFamily: "Poppins-Bold",
);
const textMediumLarge = TextStyle(
  fontSize: 20.0,
  fontWeight: FontWeight.w500,
  fontFamily: "Poppins-Bold",
);
const textMediumWhite = TextStyle(
  color: Colors.white,
  fontSize: 16.0,
  fontWeight: FontWeight.w500,
  fontFamily: "Poppins-Bold",
);
const textLarge = TextStyle(
  fontSize: 24.0,
  fontWeight: FontWeight.w500,
  fontFamily: "Poppins-Bold",
);

const textThin = TextStyle(
  fontSize: 16.0,
  fontWeight: FontWeight.w700,
  fontFamily: "Nunito-SemiBold",
);

const textThinLarge = TextStyle(
  fontSize: 20.0,
  fontWeight: FontWeight.w600,
  fontFamily: "Nunito-SemiBold",
);

const textThinBold = TextStyle(
  fontSize: 14.0,
  fontWeight: FontWeight.w800,
  fontFamily: "Nunito-Bold",
);

const textThinSuperBold = TextStyle(
  fontSize: 14.0,
  fontWeight: FontWeight.w900,
  fontFamily: "Roboto",
);

class MyStrings {
  //STRING
  static const String appName = "BINGHAN";
  static const String appTitle = "PT. Gruper.co";

  static const String textHome = "Home";
  static const String textProduct = "Product";
  static const String textOrderHistory = "History";
  static const String textNetwork = "Group";
  static const String textProfile = "Profile";
}

// String formatIDR(int n) {
//   if (n == null) {
//     return "IDR 0";
//   }

//   MoneyFormatterOutput fo = FlutterMoneyFormatter(
//     amount: n.toDouble(),
//     settings: MoneyFormatterSettings(
//       symbol: 'IDR',
//       thousandSeparator: '.',
//       decimalSeparator: ',',
//       symbolAndNumberSeparator: ' ',
//       fractionDigits: 0,
//       compactFormatType: CompactFormatType.short,
//     ),
//   ).output;
//   return fo.symbolOnLeft.toString();
// }
