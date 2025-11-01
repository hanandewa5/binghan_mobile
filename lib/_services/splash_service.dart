import 'package:binghan_mobile/_config/locator.dart';
import 'package:binghan_mobile/_services/api_get.dart';
import 'package:binghan_mobile/models/res_api.dart';
import 'dart:async';
import 'dart:io';

class SplashService {
  final ApiGet _apiGet = locator<ApiGet>();

  Future<ResApi> checkConnection() async {
    try {
      final check = await InternetAddress.lookup('google.com')
          .timeout(Duration(seconds: 5));
      if (check.isNotEmpty && check[0].rawAddress.isNotEmpty) {
        var result = ResApi(code: 200, msg: "Berhasil", data: null);
        return result;
      }
      return ResApi(code: 400, msg: "GAGAL", data: null);
    } on SocketException catch (_) {
      var result = ResApi(code: 400, msg: "GAGAL", data: null);
      return result;
    } on TimeoutException catch (_) {
      return ResApi(code: 400, msg: "GAGAL", data: null);
    }
  }

  Future<ResApi> checkVersion(String data) async {
    var result = await _apiGet.chcekVersion(data);
    return result;
  }
}
