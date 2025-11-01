import 'dart:convert';
import 'package:binghan_mobile/models/res_api.dart';
import 'package:http/http.dart' as http;
import 'package:binghan_mobile/_constants/app_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiPut {
  var client = http.Client();
  static const endpoint = AppConfig.apiUrl;
  var header = Map<String, String>.from(AppConfig.header);
  static const cartEndpoint = '$endpoint/v1/order-details';
  static const memberEndpoint = '$endpoint/v1/members';
  static const invoiceEndpoint = '$endpoint/v1/invoices';
  static const authEndpoint = '$endpoint/auth';

  Future requestPutWithToken(
    String endpointUrl,
    Map<String, dynamic>? data,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    header["Authorization"] = prefs.getString("token") ?? '';
    var body = json.encode(data);
    try {
      var response = await client
          .put(Uri.parse(endpointUrl), headers: header, body: body)
          .timeout(Duration(seconds: AppConfig.timeoutRequest));
      return json.decode(response.body);
    } catch (e) {
      print(e.toString());
      Map<String, dynamic> data = {
        "code": 500,
        "msg": "No Internet Access",
        "data": null,
      };
      return data;
    }
  }

  Future<ResApi> editMember(int? id, Map<String, dynamic>? data) async {
    var result = await requestPutWithToken('$memberEndpoint/$id', data);
    return ResApi.fromJson(result);
  }

  Future<ResApi> editCart(int? id, Map<String, dynamic>? data) async {
    var result = await requestPutWithToken('$cartEndpoint/$id', data);
    return ResApi.fromJson(result);
  }

  Future<ResApi> editPassword(int? id, Map<String, dynamic>? data) async {
    var result = await requestPutWithToken('$authEndpoint/change/$id', data);
    return ResApi.fromJson(result);
  }

  Future<ResApi> setCompleteInvoice(int? id) async {
    Map<String, dynamic> data = {};
    var result = await requestPutWithToken(
      '$invoiceEndpoint/complete/$id',
      data,
    );
    return ResApi.fromJson(result);
  }
}
