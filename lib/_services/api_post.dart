import 'dart:convert';
import 'dart:io';
import 'package:binghan_mobile/models/confirm_callback.dart';
import 'package:binghan_mobile/models/courier_service.dart';
import 'package:binghan_mobile/models/invoice_callback.dart';
import 'package:path/path.dart';
import 'package:binghan_mobile/models/auth.dart';
import 'package:binghan_mobile/models/res_api.dart';
import 'package:binghan_mobile/_constants/app_config.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiPost {
  var client = new http.Client();
  static const endpoint = AppConfig.apiUrl;
  var header = new Map<String, String>.from(AppConfig.header);
  static const authEndpoint = '$endpoint/auth';
  static const memberEndpoint = '$endpoint/v1/members';
  static const uploadEndpoint = '$endpoint/v1/upload';
  static const cartEndpoint = '$endpoint/v1/order-details';
  static const costEndpoint = '$endpoint/v1/get-cost';
  static const pvEndpoint = '$endpoint/v1/point-values';
  static const invoiceEndpoint = '$endpoint/v1/invoicesmulti';
  static const bonusEndpoint = '$endpoint/v1/bonus';

  // START AUTHENTICATION -->
  // Future<Auth> login(String binghanId, String password) async {
  //   Map data = {"binghan_id": binghanId, "password": password};
  //   var body = json.encode(data);
  //   try {
  //     var response = await client
  //         .post('$authEndpoint/login', headers: header, body: body)
  //         .timeout(Duration(seconds: AppConfig.timeoutRequest));
  //     // var userData =
  //     //     (json.decode(response.body) as Map<String, dynamic>)['msg'];
  //     return Auth.fromJson(json.decode(response.body));
  //   } catch (e) {
  //     print(e.toString());
  //     Map<String, dynamic> data = {
  //       "code": 500,
  //       "msg": "No Internet Access",
  //       "data": null
  //     };
  //     return Auth.fromJson(data);
  //   }
  // }

  Future<Auth> login(Map<String, dynamic> data) async {
    var result = await requestPostWithoutToken('$authEndpoint/login', data);
    return Auth.fromJson(result);
  }

  Future<Auth> forgotPass(String email) async {
    Map data = {"email": email};
    var body = json.encode(data);
    try {
      var response = await client.post(
        Uri.parse('$authEndpoint/forgot'),
        headers: header,
        body: body,
      );
      return Auth.fromJson(json.decode(response.body));
    } catch (e) {
      Map<String, dynamic> data = {
        "code": 500,
        "msg": "No Internet Access",
        "data": null,
      };
      return Auth.fromJson(data);
    }
  }

  Future<Auth> resetPass(String email, String token) async {
    Map data = {"email": email, "token": token};
    var body = json.encode(data);
    try {
      var response = await client.put(
        Uri.parse('$authEndpoint/reset'),
        headers: header,
        body: body,
      );
      return Auth.fromJson(json.decode(response.body));
    } catch (e) {
      Map<String, dynamic> data = {
        "code": 500,
        "msg": "No Internet Access",
        "data": null,
      };
      return Auth.fromJson(data);
    }
  }

  // <-- END AUTHENTICATION

  Future requestPostWithoutToken(
    String endpointUrl,
    Map<String, dynamic> data,
  ) async {
    var body = json.encode(data);
    try {
      var response = await client
          .post(Uri.parse(endpointUrl), headers: header, body: body)
          .timeout(Duration(seconds: AppConfig.timeoutRequest));
      return json.decode(response.body);
    } catch (e) {
      Map<String, dynamic> data = {
        "code": 500,
        "msg": "Connection problem, please try again",
        "data": null,
      };
      return data;
    }
  }

  Future requestPostWithToken(
    String endpointUrl,
    Map<String, dynamic> data,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    header["Authorization"] = prefs.getString("token") ?? '';
    var body = json.encode(data);
    try {
      var response = await client.post(
        Uri.parse(endpointUrl),
        headers: header,
        body: body,
      );
      return json.decode(response.body);
    } catch (e) {
      Map<String, dynamic> data = {
        "code": 500,
        "msg": "No Internet Access",
        "data": null,
      };
      return data;
    }
  }

  Future<ResApi> saveMember(Map<String, dynamic> data) async {
    var result = await requestPostWithToken(memberEndpoint, data);
    return ResApi.fromJson(result);
  }

  Future<ResApi> addToCart(Map<String, dynamic> data) async {
    var result = await requestPostWithToken(cartEndpoint, data);
    return ResApi.fromJson(result);
  }

  Future<CourierService> getCost(Map<String, dynamic> data) async {
    var result = await requestPostWithToken(costEndpoint, data);
    return CourierService.fromJson(result);
  }

  Future<ResApi> transferPV(Map<String, dynamic> data) async {
    var result = await requestPostWithToken(pvEndpoint, data);
    return ResApi.fromJson(result);
  }

  Future<InvoiceCallback> saveInvoice(Map<String, dynamic> data) async {
    var result = await requestPostWithToken(invoiceEndpoint, data);
    return InvoiceCallback.fromJson(result);
  }

  Future<KonfirmCallback> confirmInvoice(Map<String, dynamic> data) async {
    var result = await requestPostWithToken(
      '$invoiceEndpoint/konfirmasi',
      data,
    );
    return KonfirmCallback.fromJson(result);
  }

  Future<ResApi> calcBonus(Map<String, dynamic> data) async {
    var result = await requestPostWithToken('$bonusEndpoint/calc-bonus', data);
    return ResApi.fromJson(result);
  }

  Future<ResApi> uploadImage(Map<String, dynamic>? data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var dio = Dio();
      File imageFile = data?['file'];
      Map<String, dynamic> header = {"Authorization": prefs.getString("token")};
      FormData formData = new FormData.fromMap({
        "jenis_file": data?['jenis_file'],
        "nama_file": data?['nama_file'],
        "file": await MultipartFile.fromFile(
          imageFile.path,
          filename: basename(imageFile.path),
        ),
      });
      Response response = await dio.post(
        uploadEndpoint,
        data: formData,
        options: Options(headers: header),
      );
      return ResApi.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
